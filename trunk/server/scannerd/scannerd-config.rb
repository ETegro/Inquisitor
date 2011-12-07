$CLIENT_PORT=8372
$SERVER_ADDR="localhost:80"

$SCANNERD_RESET_SEQ = "reset"

$PAIRED_SCANS = [
	['C','S'],
	['S','O'],
	['S','P','T','A'],
	['S','P','I','T','A']
]

$TIMEOUT_LIMIT=600
#$SCANNER_FILENAMES=[ '/dev/ttyUSB0' ]
#$SCANNER_FILENAMES=[ '/dev/null' ]
#$SCANNER_FILENAMES=[ '/dev/stdin' ]
$SCANNER_FILENAMES=[ '/dev/ttyS1' ]
