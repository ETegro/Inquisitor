#!/bin/bash -x

max_pass=$1
output="output.`date +%Y.%m.%d-%H%M`"
touch $output
touch mceErrors

trap cleanup 1 2 3 6
cleanup ()
{
	echo ""
	echo "Stopping stress test."
	echo -n "..Killing HPL process........"
	killall xhpl 2>/dev/null
	echo "Done."
	echo -n "..Killing mceCheck process..."
	kill -9 $background 2>/dev/null 1>/dev/null
	echo "Done."
	echo ""
	echo -n "..Printing results..........."

	awk ' BEGIN { pass=0 } ; /WR/ { split($7,a,"e") ; printf "\nPASS%4s == %8.4f%s ", pass , a[1] * 10 ^ a[2], "GFlops" ; pass++ } ; /Ax-b/ { printf " " $11 } ; END { print "\n" } ' $output | tee -a $output.results

	if test "`awk ' /GFlops/ { print $5 , $6 , $7 } ' $output.results | sort -u | wc -l`" -le 1; then
		echo "PASS: No corruption found."
	else
		echo "FAIL: Corruption found!"
	fi

	if grep "" < mceErrors 1>/dev/null 2>/dev/null; then
		echo "FAIL: MCE Errors occured!"
	else
		echo "PASS: No MCE Errors occured."
	fi

	timeTestStop=`date +%s`
	echo $timeTestStart $timeTestStop | awk '{ print "HPL Ran for " ( $2 - $1 ) / 60 " minutes before stopping." }' | tee -a  $output 

	wait
	exit 0
}

cursor[0]='|'
cursor[1]='/'
cursor[2]='-'
cursor[3]='\'
cursor[4]='|'
pos=0
let breakout=1
update_cursor ()
{
	printf "\b"${cursor[pos]}
	pos=$(( ( pos + 1 ) % 5 ))
}

trap "let breakout=0" USR1
export this_pid=$$
trap cleanup 31 12 17

./checkmce $this_pid &
background=$!

if grep -iq "vendor.*intel" /proc/cpuinfo; then
	src="intel/xhpl_intel64"
else
	src="amd/xhpl_amd64"
fi
ln -s ../$src xhpl

CPUcount=`grep ^processor < /proc/cpuinfo | wc -l`

Ps=0
Qs=0
case "$CPUcount" in
	"1") Ps=1 ; Qs=1 ;;
	"2") Ps=1 ; Qs=2 ;;
	"4") Ps=2 ; Qs=2 ;;
	"6") Ps=1 ; Qs=6 ;;
	"8") Ps=2 ; Qs=4 ;;
	"12") Ps=2 ; Qs=6 ;;
	"16") Ps=4 ; Qs=4 ;;
	"24") Ps=4 ; Qs=6 ;;
	"32") Ps=4 ; Qs=8 ;;
	"40") Ps=4 ; Qs=10 ;;
	"48") Ps=6 ; Qs=8 ;;
	"80") Ps=4 ; Qs=20 ;;
esac
[ "$Ps" = "0" -o "$Qs" = "0" ] && exit 1

MEM=`free | awk ' /Mem:/ { print sqrt( ( $2 - 524288 ) * 0.92 * 1024 / 8 ) } '`

cat HPL.base | sed 6s/replaceNs/$MEM/g | sed 11s/replacePs/$Ps/g | sed 12s/replaceQs/$Qs/g > HPL.dat

MEMused="`echo $MEM | awk ' { print $MEM ^ 2 * 8 / 1024 / 1024 } '`"
MEMseen="`free -m | awk ' /Mem:/ { print $2 } '`"

echo " ____  _                                      _   _ ____  _     "
echo "/ ___|| |_ __ _ _ __ __ _ _ __ __ ___   _____| | | |  _ \| |    "
echo "\___ \| __/ _' | '__/ _' | '__/ _' \ \ / / _ \ |_| | |_) | |    "
echo " ___) | || (_| | | | (_| | | | (_| |\ V /  __/  _  |  __/| |___ "
echo "|____/ \__\__,_|_|  \__, |_|  \__,_| \_/ \___|_| |_|_|   |_____|"
echo "                    |___/                                       "
echo
echo "CPU: Using $CPUcount processor cores."
echo "RAM: Using ${MEMused}MB of the ${MEMseen}MB seen."
echo

timeTestStart=`date +%s`
pass=0
[ $max_pass -gt 0 ] || exit 1
while [ "$pass" -le "$max_pass" ]; do
	let breakout=1 

	mpirun -np $CPUcount ./xhpl >> $output && kill -USR1 $this_pid &
	echo -n  "Running pass $pass...  "
	timePassStart=`date +%s`
	while [[ $breakout -eq 1 ]]; do
		update_cursor
		sleep .2
	done 
	timePassStop=`date +%s`

	echo $timePassStart $timePassStop | awk '{printf "TimeToComplete was %7.4f minutes." , ( $2 - $1 ) / 60 }' >> $output

	clear
	awk ' BEGIN { pass=0 } ; /WR/ { split($7,a,"e") ; printf "\nPASS%4s == %8.4f%s ", pass , a[1] * 10 ^ a[2], "GFlops" ; pass++ } ; /Ax-b/ { printf " " $11 } ; /TimeToComplete/ { printf " , " $3 " min" } ; END { print "\n" } ' $output

	/usr/sbin/mcelog >> mceErrors

	grep "" < mceErrors 1>/dev/null 2>/dev/null && exit 1 || echo "No MCE Errors found."

	let pass=pass+1
done
