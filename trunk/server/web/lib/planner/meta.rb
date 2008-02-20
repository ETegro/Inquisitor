# DO NOT EDIT: IT'S A GENERATED FILE! USE ./configure to REGENERATE!

$TESTS = {"gprs-modem"=>
  {:poweroff_during_test=>false,
   :var=>
    {"CHAT_TIMEOUT"=>
      {:type=>"int",
       :default=>"5",
       :comment=>"Timeout for waiting for answer"},
     "ANSWER_ATI"=>
      {:type=>"string", :default=>"OK", :comment=>"String to get after ATI"},
     "DEV"=>
      {:type=>"string",
       :default=>"/dev/ttyUSB0",
       :comment=>"Name of device to test"}},
   :description=>"Test GPRS modem, connected using USB",
   :name=>"USB GPRS modem",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "memory"=>
  {:poweroff_during_test=>false,
   :var=>
    {"TEST_LOOPS"=>
      {:type=>"int", :default=>"3", :comment=>"Number of testing loops"},
     "LOGTIME"=>
      {:type=>"int",
       :default=>"120",
       :comment=>"Time between progress updates, sec"}},
   :description=>"Memory test",
   :name=>"Memory",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "hdd-array"=>
  {:poweroff_during_test=>false,
   :var=>
    {"JOBS"=>
      {:type=>"int",
       :default=>"16",
       :comment=>"Number of parallely running jobs during compile"},
     "STRESS_TREE"=>
      {:type=>"string",
       :default=>"linux-2.6.22.5-31-stress.tar.gz",
       :comment=>"Tarball file containing stress test tree"},
     "TESTTIME"=>
      {:type=>"int",
       :default=>"3600",
       :comment=>"Total time of HDD array testing, sec"},
     "LOGTIME"=>
      {:type=>"int",
       :default=>"120",
       :comment=>"Time between progress updates, sec"}},
   :description=>"HDD array stress test",
   :name=>"HDD array stress",
   :version=>"0.1",
   :destroys_hdd=>true,
   :is_interactive=>false},
 "mencoder"=>
  {:poweroff_during_test=>false,
   :var=>
    {"FILE_TO_ENCODE"=>
      {:type=>"string",
       :default=>"/usr/share/inquisitor/movie.avi",
       :comment=>"Path to file need to be encoded"},
     "ENCODE_OPTIONS"=>
      {:type=>"string",
       :default=>
        "-ovc lavc -lavcopts vcodec=mpeg4 -oac mp3lame -lameopts vbr=3",
       :comment=>"Encoding options"}},
   :description=>"Mencoder encoding time benchmark",
   :name=>"Mencoder",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "stream"=>
  {:poweroff_during_test=>false,
   :var=>{},
   :description=>"STREAM memory throughput benchmark",
   :name=>"Stream",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "dhrystone"=>
  {:poweroff_during_test=>false,
   :var=>
    {"DURATION"=>
      {:type=>"int", :default=>"30", :comment=>"Benchmark duration (sec)"}},
   :description=>"Dhrystone integer calculations benchmark",
   :name=>"Dhrystone",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "usb-flash-drive"=>
  {:poweroff_during_test=>false,
   :var=>
    {"SIZE"=>
      {:type=>"int",
       :default=>"20",
       :comment=>"Size of test file to be written, MiB"},
     "COUNT"=>
      {:type=>"int",
       :default=>"2",
       :comment=>"There should be this many devices"},
     "BLOCKSIZE"=>
      {:type=>"int",
       :default=>"1024",
       :comment=>"Blocksize used for reading and writing by dd, KiB"}},
   :description=>"USB Flash Drive working ability test with speed measurement",
   :name=>"USB Flash Drive",
   :version=>"0.1",
   :destroys_hdd=>true,
   :is_interactive=>true},
 "odd_read"=>
  {:poweroff_during_test=>false,
   :var=>
    {"MESH_POINTS"=>
      {:type=>"int",
       :default=>"1024",
       :comment=>"Points for meshes for monitoring drive's speed"},
     "TEST_IMAGE_BLOCKS"=>
      {:type=>"int",
       :default=>"332800",
       :comment=>"This images size in blocks (2048 bytes each)"},
     "FORCE_NON_INTERACTIVE"=>
      {:type=>"boolean",
       :default=>"false",
       :comment=>"Force non-interactive mode for already prepared system"},
     "TEST_IMAGE_HASH"=>
      {:type=>"string",
       :default=>"6fa7786eef2e11d36e8bc1663679f161",
       :comment=>"Default image for comparison hash"}},
   :description=>"Optical Disc Drive read test",
   :name=>"ODD read",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>true},
 "odd_write-pass1"=>
  {:poweroff_during_test=>false,
   :var=>
    {"ODD_TEST_IMAGE_BLOCKS"=>
      {:type=>"int",
       :default=>"332800",
       :comment=>"This images size in blocks (2048 bytes each)"},
     "ODD_WRITE_SPEED"=>
      {:type=>"int",
       :default=>"10",
       :comment=>"Default write speed if it won't detect"},
     "ODD_TEST_IMAGE"=>
      {:type=>"str",
       :default=>"/usr/share/inquisitor/ets1.iso",
       :comment=>"Default image for comparison"}},
   :description=>"Optical Disc Drive write test, writing first etegro's disk",
   :name=>"odd_write-pass1",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "gprs-modem-dialup"=>
  {:poweroff_during_test=>false,
   :var=>
    {"SPEED"=>{:type=>"int", :default=>"115200", :comment=>"Line speed"},
     "URL"=>
      {:type=>"string",
       :default=>
        "img-fotki.yandex.ru/getx/10/photoface.359/sevastopol-foto_34661_L",
       :comment=>"URL to download (without http)"},
     "DOWNLOAD_TRIES"=>
      {:type=>"int",
       :default=>"3",
       :comment=>"Number of tries to download the file"},
     "PPPD_TRIES"=>
      {:type=>"int",
       :default=>"4",
       :comment=>"Number of tries to bring pppd up"},
     "MD5"=>
      {:type=>"string",
       :default=>"ca530886183b06d0047e0655537327aa",
       :comment=>"MD5 of downloaded file"},
     "DOWNLOAD_MAX_TIME"=>
      {:type=>"int",
       :default=>"60",
       :comment=>"Timeout for the whole download, sec"},
     "APN"=>
      {:type=>"string",
       :default=>"internet.mts.ru",
       :comment=>"Cell service provider's Internet APN"},
     "DEV"=>
      {:type=>"string",
       :default=>"/dev/ttyUSB0",
       :comment=>"Name of device to test"}},
   :description=>"Test GPRS modem, connected using USB",
   :name=>"USB GPRS Modem Dialup",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "fdd"=>
  {:poweroff_during_test=>false,
   :var=>
    {"FLOPPY_SIZE"=>
      {:type=>"int",
       :default=>"1440",
       :comment=>"Size of testing floppy, KiB"}},
   :description=>"Floppy drive read/write test",
   :name=>"FDD read/write",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>true},
 "odd_write-pass2"=>
  {:poweroff_during_test=>false,
   :var=>
    {"ODD_TEST_IMAGE_BLOCKS"=>
      {:type=>"int",
       :default=>"332800",
       :comment=>"This images size in blocks (2048 bytes each)"},
     "ODD_WRITE_SPEED"=>
      {:type=>"int",
       :default=>"10",
       :comment=>"Default write speed if it won't detect"},
     "ODD_TEST_IMAGE"=>
      {:type=>"str",
       :default=>"/usr/share/inquisitor/ets1.iso",
       :comment=>"Default image for comparison"}},
   :description=>"Optical Disc Drive write test, writing first etegro's disk",
   :name=>"odd_write-pass2",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "net"=>
  {:poweroff_during_test=>false,
   :var=>
    {"URL"=>
      {:type=>"string",
       :default=>"3000/test_file",
       :comment=>"Relative to server PORT:URL to be fetched and checked"},
     "TIMEOUT"=>
      {:type=>"int",
       :default=>"15",
       :comment=>"Wait timeout while test file retrieving, sec"},
     "MD5"=>
      {:type=>"string",
       :default=>"805414334eb1d3ff4fdca507ec82098f",
       :comment=>"MD5 checksum for checking"}},
   :description=>"Network interfaces testing",
   :name=>"Network interface",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "odd_write"=>
  {:poweroff_during_test=>false,
   :var=>
    {"WRITE_SPEED_FORCE"=>
      {:type=>"boolean",
       :default=>"true",
       :comment=>"Force write speed using"},
     "TEST_IMAGE_BLOCKS"=>
      {:type=>"int",
       :default=>"332800",
       :comment=>"This images size in blocks (2048 bytes each)"},
     "FORCE_NON_INTERACTIVE"=>
      {:type=>"boolean",
       :default=>"false",
       :comment=>"Force non-interactive mode for already prepared system"},
     "TEST_IMAGE_MD5"=>
      {:type=>"string",
       :default=>"ffffffffffffffffffffffffffffffff",
       :comment=>"Test image MD5 hash"},
     "WRITE_MESSAGE"=>
      {:type=>"string",
       :default=>"Writing test disc",
       :comment=>"Message to print when test will start"},
     "WRITE_SPEED"=>
      {:type=>"int",
       :default=>"10",
       :comment=>"Default write speed if it won't detect"},
     "TEST_IMAGE"=>
      {:type=>"string",
       :default=>"iso/testimage.iso",
       :comment=>"ISO image path (absolute or relative)"}},
   :description=>"Optical Disc Drive write test",
   :name=>"odd_write",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>true},
 "gprs-modem-level"=>
  {:poweroff_during_test=>false,
   :var=>
    {"CHAT_TIMEOUT"=>
      {:type=>"int",
       :default=>"5",
       :comment=>"Timeout for waiting for answer"},
     "DEV"=>
      {:type=>"string",
       :default=>"/dev/ttyUSB0",
       :comment=>"Name of device to test"}},
   :description=>
    "Measure signal level, received by GPRS modem, connected via USB",
   :name=>"USB GPRS modem signal level",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "hdparm"=>
  {:poweroff_during_test=>false,
   :var=>
    {"AVG_SAMPLES"=>
      {:type=>"int",
       :default=>"5",
       :comment=>"Number of tests per disc to average for result"}},
   :description=>"Hdparm HDD speed benchmark",
   :name=>"Hdparm",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "unixbench"=>
  {:poweroff_during_test=>false,
   :var=>{},
   :description=>"UNIX Bench Multi-CPU benchmark",
   :name=>"Unixbench",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "hdd-passthrough"=>
  {:poweroff_during_test=>false,
   :var=>
    {"JOBS"=>
      {:type=>"int",
       :default=>"16",
       :comment=>
        "Number of parallely running jobs during stress test tree compile"},
     "DISK_GROUP_SIZE"=>
      {:type=>"int",
       :default=>"8",
       :comment=>"Number of disks per group for testing"},
     "MINIMAL_STRESS_TIME"=>
      {:type=>"int",
       :default=>"600",
       :comment=>"Minimal time of stress testing"},
     "RAMDISK_SIZE"=>
      {:type=>"int",
       :default=>"400",
       :comment=>"Size of memory disk for stress tree building, MB"},
     "STRESS_TREE"=>
      {:type=>"string",
       :default=>"linux-2.6.22.5-31-stress.tar.gz",
       :comment=>"Tarball file containing stress test tree"}},
   :description=>"HDD passthrough disks test",
   :name=>"HDD passthrough disk",
   :version=>"0.1",
   :destroys_hdd=>true,
   :is_interactive=>false},
 "cpu"=>
  {:poweroff_during_test=>false,
   :var=>
    {"TESTTIME"=>
      {:type=>"int",
       :default=>"1800",
       :comment=>"Total time of CPU testing, sec"}},
   :description=>"CPU burn-in testing",
   :name=>"CPU burning",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "usb-device"=>
  {:poweroff_during_test=>false,
   :var=>
    {"IDVENDOR"=>
      {:type=>"string",
       :default=>"0403",
       :comment=>
        "Filter in only devices with this idVendor (match all if empty)"},
     "COUNT"=>
      {:type=>"int",
       :default=>"1",
       :comment=>"There should be this many devices"},
     "IDPRODUCT"=>
      {:type=>"string",
       :default=>"6001",
       :comment=>
        "Filter in only devices with this idProduct (match all if empty)"}},
   :description=>"Tests presence of designated USB device",
   :name=>"USB presence",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "bonnie"=>
  {:poweroff_during_test=>false,
   :var=>{},
   :description=>"Bonnie HDD performance benchmark",
   :name=>"Bonnie",
   :version=>"0.1",
   :destroys_hdd=>true,
   :is_interactive=>false},
 "whetstone"=>
  {:poweroff_during_test=>false,
   :var=>{"LOOPS"=>{:type=>"int", :default=>"20000", :comment=>"Loop count"}},
   :description=>"Whetstone floating-point calculations benchmark",
   :name=>"Whetstone",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false},
 "flash"=>
  {:poweroff_during_test=>false,
   :var=>
    {"SIZE_LIMIT"=>
      {:type=>"int",
       :default=>"2048",
       :comment=>"That is less than this amount is an IDE flash, MiB"}},
   :description=>"Flash disk badblocks test",
   :name=>"Flash disk",
   :version=>"0.1",
   :destroys_hdd=>true,
   :is_interactive=>false},
 "bytemark"=>
  {:poweroff_during_test=>false,
   :var=>{},
   :description=>"BYTEmark native mode benchmark",
   :name=>"BYTEmark",
   :version=>"0.1",
   :destroys_hdd=>false,
   :is_interactive=>false}}

