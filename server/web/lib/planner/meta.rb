# DO NOT EDIT: IT'S A GENERATED FILE! USE ./configure to REGENERATE!

$TESTS = {"hdd-array"=>
  {:description=>
    "HDD array is a stress test that causes high load on HDD array subsystem. First of all it creates a filesystem on each array and unpacks and compiles there a large source tree for a specified time. Test distributes specified test duration among created arrays equally. Compilation, as in hdd-passthrough test, goes with 16 simultaneous jobs (by default). Test will finish successfully if there won't be any errors in filesystem creation and source code compilation runs. Usually this test starts after the CPU burning, memory and hdd-passthrough ones, and thus failing of this test (considering successful previous tests) usually identifies a broken RAID controller.",
   :version=>"0.1",
   :depends=>["CPU", "HDD", "Memory", "Mainboard", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD array stress",
   :var=>
    {"STRESS_TREE"=>
      {:type=>"string",
       :comment=>"Tarball file containing stress test tree",
       :default=>"linux-stress.tar.gz"},
     "JOBS"=>
      {:type=>"int",
       :comment=>"Number of parallely running jobs during compile",
       :default=>"16"},
     "LOGTIME"=>
      {:type=>"int",
       :comment=>"Time between progress updates, sec",
       :default=>"120"},
     "MINIMAL_DRIVE_SIZE"=>
      {:type=>"int",
       :comment=>"That is less than this amount is an flash device, MiB",
       :default=>"2048"},
     "TESTTIME"=>
      {:type=>"int",
       :comment=>"Total time of HDD array testing, sec",
       :default=>"3600"}}},
 "iozone"=>
  {:description=>
    "This benchmark measures the speed of sequential I/O to actual files. It generates and measures a variety of file operations.",
   :version=>"0.1",
   :depends=>["HDD"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD benchmark: IOzone",
   :var=>
    {"TEST_FILE_SIZE"=>
      {:type=>"int",
       :comment=>
        "Size of test file, MiB. If set to zero - double memory amount size will be used",
       :default=>"0"}}},
 "dd"=>
  {:description=>
    "Actually this is not a real test. It can be used to write prepared raw disk image using DD utility.",
   :version=>"0.2",
   :depends=>["HDD", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"DD",
   :var=>
    {"OF"=>
      {:type=>"string",
       :comment=>"Target device name that will be overwritten",
       :default=>"sda"},
     "COUNT"=>
      {:type=>"int",
       :comment=>
        "Number of blocks to be written. If zero is specified then this parameter won't be used",
       :default=>"1024"},
     "BLOCKSIZE"=>{:type=>"int", :comment=>"Blocksize, KiB", :default=>"1024"},
     "IF"=>
      {:type=>"string",
       :comment=>
        "Either absolute or relative path to source raw disk image to be written, or URL to download",
       :default=>"raw_disk_image"},
     "SKIP"=>
      {:type=>"int", :comment=>"Number of blocks to skip", :default=>"0"},
     "COMPRESSION"=>
      {:type=>"string",
       :comment=>"What compression is used. gzip, bzip2 or lzma can be chosen",
       :default=>"none"}}},
 "db_comparison_fast"=>
  {:description=>
    "Compare detected hardware components with pre-generated reference YAML file. This file can be created with list_components method on server-side.",
   :version=>"0.1",
   :depends=>
    ["BMC",
     "CPU",
     "Chassis",
     "Disk Controller",
     "Floppy",
     "HDD",
     "Mainboard",
     "Memory",
     "NIC",
     "OSD",
     "Platform",
     "USB",
     "Video",
     "ODD",
     "GPRS Modem",
     "USB Mass Storage"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Reference-based detects comparison",
   :var=>
    {"EXCLUDED_MODELS"=>
      {:type=>"string",
       :comment=>"Excluded component models from comparison",
       :default=>""},
     "FILENAMES"=>
      {:type=>"string", :comment=>"Reference files", :default=>""}}},
 "torrent-upload"=>
  {:description=>
    "This test uses BitTorrent client (Enhanced CTorrent) to download specified torrent. With its modified version it can write directly on block devices.",
   :version=>"0.1",
   :depends=>["HDD", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Torrent upload",
   :var=>
    {"SEED_AFTER"=>
      {:type=>"bool",
       :comment=>"Seed after successfull test finishing?",
       :default=>"true"},
     "TARGET"=>
      {:type=>"string",
       :comment=>"Target device name that will be overwritten",
       :default=>"/dev/sda"},
     "TORRENT"=>
      {:type=>"string",
       :comment=>
        "Either absolute or relative path to .torrent file. Be sure that tracker is available from network",
       :default=>"test.torrent"}}},
 "boot_from_image"=>
  {:description=>
    "This is not real test. It will always succeed if file is available for booting. Can be used to force single booting from image file without any checks about its successful finishing.",
   :version=>"0.1",
   :depends=>[],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>true,
   :name=>"Boot from image",
   :var=>
    {"IMAGE"=>
      {:type=>"string",
       :comment=>"Image to boot from after rebooting",
       :default=>"boot_image.img"}}},
 "stream"=>
  {:description=>
    "The STREAM benchmark is a simple synthetic benchmark program that measures sustainable memory bandwidth (in MiB/s) and the corresponding computation rate for simple vector kernels. This benchmark uses stream version written in C language and optimized either for single processor systems or for multiprocessor systems with help of OpenMP.",
   :version=>"0.1",
   :depends=>["Memory"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Memory benchmark: STREAM",
   :var=>
    {"THREADS"=>
      {:type=>"int",
       :comment=>
        "Force using specified number of threads. If equal to zero, then load all available CPUs. This option works only with OpenMP version of stream",
       :default=>"0"}}},
 "memory"=>
  {:description=>
    "This memory test is performed without reboot, under control of live full-featured OS, using user-space memtester program. Test takes special precautions and tries to lock maximum possible amount of memory for memtester. memtester tests memory using standard read-write-check method using 16 patterns.",
   :version=>"0.1",
   :depends=>["Memory"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Memory test: Memtester",
   :var=>
    {"TEST_LOOPS"=>
      {:type=>"int", :comment=>"Number of testing loops", :default=>"1"},
     "LOGTIME"=>
      {:type=>"int",
       :comment=>"Time between progress updates, sec",
       :default=>"120"}}},
 "openssl-speed"=>
  {:description=>
    "This benchmark measures different OpenSSL algorithm's speed with different block sizes (for symmetric algorithms) or key sizes for signing and verifying.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"openssl-speed",
   :var=>{}},
 "mencoder_hdd"=>
  {:description=>
    "This benchmark will transcode specified input file to H.264 video, copying without modification audio in (by default) AVI container. You can specify also preset (taken from MPlayerHQ's documentation examples for x264), scaling and bitrate. Two-pass encoding option is available too. This benchmark will use x264's multithreading capabilities to load all CPUs or can run using specified number of threads.",
   :version=>"0.1",
   :depends=>["CPU", "Memory", "Mainboard", "Disk Controller", "HDD"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Mencoder on hard drive",
   :var=>
    {"PRESET"=>
      {:type=>"string",
       :comment=>
        "Encoding preset. \"lq\" (low quality), \"hq\" (high quality) and \"vhq\" (very high quality) are availabe",
       :default=>"hq"},
     "SCALE"=>
      {:type=>"string",
       :comment=>"Width and height for rescaling resulting image",
       :default=>"720x480"},
     "THREADS"=>
      {:type=>"int",
       :comment=>
        "Force using specified number of threads. If equal to zero, then load all available CPUs",
       :default=>"0"},
     "BITRATE"=>
      {:type=>"int",
       :comment=>"Bitrate of resulting video, KB/sec",
       :default=>"1000"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>"Source transcoding file",
       :default=>"movie.mpeg2"},
     "TWOPASS"=>
      {:type=>"boolean",
       :comment=>"Enable two-pass encoding of not",
       :default=>"false"}}},
 "check-component-existence"=>
  {:description=>
    "It is not a real test. It just checks if specified component exists in system. Mainly it can be used as an assumption for real tests, that will succeed if no related components where found.",
   :version=>"0.1",
   :depends=>[],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Check component existence",
   :var=>
    {"COUNT"=>
      {:type=>"int",
       :comment=>
        "If greater than zero, than exactly that number of components must be present.",
       :default=>"0"},
     "TYPE"=>
      {:type=>"string",
       :comment=>
        "Specify component needed to be checked. Maybe: hdd, nic, fdd, odd",
       :default=>"nic"}}},
 "vorbis-encode"=>
  {:description=>
    "This benchmark simply encodes PCM WAV audiofile to OGG/Vorbis format and calculates encoding speed.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"vorbis-encode",
   :var=>
    {"QUALITY"=>
      {:type=>"int",
       :comment=>"Specify quality, between -1 (very low) and 10 (very high)",
       :default=>"3"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>"Path to PCM WAV file to compress",
       :default=>"input.wav"}}},
 "hdd-passthrough"=>
  {:description=>
    "HDD passthrough is a stress test that imposes heavy load on main system components. First, it tries to make all HDDs present in the system to appear as separate device nodes - it checks all available RAID controllers, deletes all arrays / disk groups and creates passthrough devices to access individual HDDs if required. Second, it runs badblocks test on every available HDD, running them simulatenously in groups of 8 HDDs by default. Third, it makes a ramdisk filesystem and starts infinite compilation loop in memory, doing so with 16 simultaneous jobs (by default). Test ends successfully after both 1) minimal required stress time passes, 2) all HDDs are checked with badblocks. Test would fail if any bad blocks would be detected on any HDD. Test will usually hang or crash the system on the unstable hardware.",
   :version=>"0.3",
   :depends=>["CPU", "HDD", "Memory", "Mainboard", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD passthrough",
   :var=>
    {"STRESS_TREE"=>
      {:type=>"string",
       :comment=>"Tarball file containing stress test tree",
       :default=>"linux-stress.tar.gz"},
     "BADBLOCKS_MODE"=>
      {:type=>"string",
       :comment=>
        "Badblocks usage. Can be - read only (\"readonly\"), non-destructive read and write (\"non-destructive\"), destructive read and write (\"destructive\")",
       :default=>"readonly"},
     "JOBS"=>
      {:type=>"int",
       :comment=>
        "Number of parallely running jobs during stress test tree compile",
       :default=>"16"},
     "BADBLOCKS_BLOCKSIZE"=>
      {:type=>"int",
       :comment=>"Specify the size of blocks in bytes, bytes",
       :default=>"1024"},
     "BADBLOCKS_BLOCKS_TESTED_AT_ONCE"=>
      {:type=>"int",
       :comment=>"Number of blocks which are tested at a time.",
       :default=>"64"},
     "BADBLOCKS_PATTERN"=>
      {:type=>"string",
       :comment=>
        "Specify a test pattern to be read (and written) to disk blocks. See badblocks manual for more info.",
       :default=>""},
     "SKIP_STRESS_TESTING"=>
      {:type=>"bool",
       :comment=>"Do we need to skip stress subtest, perform only badblocks",
       :default=>"false"},
     "RAMDISK_SIZE"=>
      {:type=>"int",
       :comment=>"Size of memory disk for stress tree building, MB",
       :default=>"400"},
     "DISK_GROUP_SIZE"=>
      {:type=>"int",
       :comment=>"Number of disks per group for testing",
       :default=>"8"},
     "MINIMAL_STRESS_TIME"=>
      {:type=>"int",
       :comment=>"Minimal time of stress testing",
       :default=>"600"}}},
 "odd_read"=>
  {:description=>
    "This test checks for workability and correct optical discs reading of ODDs. It detects if disc is already loaded and tries to run test non-interactively (without any humans nearby). It reads needed number of blocks (trying readcd or dd), calculates their checksums and compares with specified one. So, we can determine either drives works fine or not. Also, simultaneously it acts as a monitoring, measuring disc reading speed.",
   :version=>"0.1",
   :depends=>["ODD"],
   :destroys_hdd=>false,
   :is_interactive=>true,
   :poweroff_during_test=>false,
   :name=>"ODD read",
   :var=>
    {"TEST_IMAGE_HASH"=>
      {:type=>"string",
       :comment=>"Default image for comparison hash",
       :default=>"6fa7786eef2e11d36e8bc1663679f161"},
     "MESH_POINTS"=>
      {:type=>"int",
       :comment=>"Points for meshes for monitoring drive's speed",
       :default=>"1024"},
     "TEST_IMAGE_BLOCKS"=>
      {:type=>"int",
       :comment=>"This images size in blocks (2048 bytes each)",
       :default=>"332800"},
     "FORCE_NON_INTERACTIVE"=>
      {:type=>"boolean",
       :comment=>"Force non-interactive mode for already prepared system",
       :default=>"false"}}},
 "fdd"=>
  {:description=>
    "A simple test to determine whether the floppy drive is either workable or not. It asks a user to insert a floppy disk into drive, then writes some random data on a it, clears the cache, reads the data back and compares it to what was written. Process repeats for every FDD available.",
   :version=>"0.1",
   :depends=>["Floppy"],
   :destroys_hdd=>false,
   :is_interactive=>true,
   :poweroff_during_test=>false,
   :name=>"FDD read/write",
   :var=>
    {"FLOPPY_SIZE"=>
      {:type=>"int",
       :comment=>"Size of testing floppy, KiB",
       :default=>"1440"}}},
 "odd_write"=>
  {:description=>
    "This test is needed to record discs and at the same time to check corectness of this operation. It can detect if rewritable/recordable media is already inserted and tries to continue non-interactively. After detecting maximal writing speed (it can be forced by an option), blanking if it is rewritable non-blank media, it records specified ISO image. Then, it reads it to compare it's checksum with original one. After all of this we can make a conclusion about drives quality.",
   :version=>"0.1",
   :depends=>["ODD"],
   :destroys_hdd=>false,
   :is_interactive=>true,
   :poweroff_during_test=>false,
   :name=>"ODD write",
   :var=>
    {"TEST_IMAGE_BLOCKS"=>
      {:type=>"int",
       :comment=>"This images size in blocks (2048 bytes each)",
       :default=>"332800"},
     "FORCE_NON_INTERACTIVE"=>
      {:type=>"boolean",
       :comment=>"Force non-interactive mode for already prepared system",
       :default=>"false"},
     "TEST_IMAGE_MD5"=>
      {:type=>"string",
       :comment=>"Test image MD5 hash",
       :default=>"ffffffffffffffffffffffffffffffff"},
     "WRITE_MESSAGE"=>
      {:type=>"string",
       :comment=>"Message to print when test will start",
       :default=>"Writing test disc"},
     "WRITE_SPEED"=>
      {:type=>"int",
       :comment=>"Default write speed if it won't detect",
       :default=>"10"},
     "TEST_IMAGE"=>
      {:type=>"string",
       :comment=>"ISO image path (absolute or relative)",
       :default=>"iso/testimage.iso"},
     "WRITE_SPEED_FORCE"=>
      {:type=>"boolean",
       :comment=>"Force write speed using",
       :default=>"true"}}},
 "usb-flash-drive"=>
  {:description=>
    "This test allows to check the working ability of USB ports and/or plugged USB storage devices. A user has to plug the USB storage devices (such as USB flash drives) in every USB port of system under test. A number of USB storage drives is passed then as a COUNT parameter to this test script. First of all, it checks if a required number of USB devices is plugged in: the test won't start if it's not so. This way, a non-working USB port would be diagnosed. The test itself does the following for every detected USB storage device: it writes a number of blocks wit random data (start position is choosen randomly to increase an USB drive's lifetime) and remembers their checksum, then it clears the disk cache and reads these blocks back, calculating checksum. If checksums match, USB device and port work properly. This test also acts as a benchmark: it measures write and read speeds. This metric can be used  to diagnose bad ports/USB devices (due to speed lower than required minimum).",
   :version=>"0.1",
   :depends=>["USB", "USB Mass Storage"],
   :destroys_hdd=>true,
   :is_interactive=>true,
   :poweroff_during_test=>false,
   :name=>"USB flash drive",
   :var=>
    {"SIZE"=>
      {:type=>"int",
       :comment=>"Size of test file to be written, Blocksizes",
       :default=>"20"},
     "COUNT"=>
      {:type=>"int",
       :comment=>"There should be this many devices",
       :default=>"2"},
     "BLOCKSIZE"=>
      {:type=>"int",
       :comment=>"Blocksize used for reading and writing by dd, KiB",
       :default=>"1024"}}},
 "hdd-smart"=>
  {:description=>
    "Simple test for SMART capable hard drives. At first it tries to find is there any SMART capable and correctly working with it drives. Test uses standard smartmontools package. Next, it starts long time full SMART testing on every capable drive and waits for their completion. If everything in SMART log seems good tests passes successfully.",
   :version=>"0.1",
   :depends=>["HDD"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD SMART",
   :var=>
    {"LOGTIME"=>
      {:type=>"int",
       :comment=>"Time between progress updates, sec",
       :default=>"120"}}},
 "dhrystone"=>
  {:description=>
    "A synthetic computing benchmark that measures CPU integer performance. Inquisitor uses a C version and runs the specified number of loops, testing each CPU separately, with testing process running affined to particular CPU. Performance rating is in terms of MIPS.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"CPU benchmark: Dhrystone",
   :var=>
    {"DURATION"=>
      {:type=>"int", :comment=>"Benchmark duration (sec)", :default=>"300"}}},
 "firmware"=>
  {:description=>
    "This test is a part of rather complex Inquisitor's firmware reflashing system. This part do following things: 1) Gets a list of components related only to this computer and needed to be reflashed. There are corresponding firmware/flash version and reflashing image also; 2) Test parses each entity and, depending of component, tries to retrieve it's version (BMC's or BIOS'es version, for example); 3) Compares it with retrieved from server needed value and if they are do not differ - proceed with need component; else - there are two ways: either to reflash it under current GNU/Linux session (to reflash disk controllers with einarc for example), or to ask server to create network bootable file with needed reflasher image; then reboot. After reboot computer will boot up reflasher image (as a rule it is some kind of DOS with batch files and flashers). Server will delete it after boot, to allow Inquisitor booting again. Firmware test will test all of components again and again in cycle until everything's versions will be equal to needed ones, and only then, test will succeed. Sometimes some component's version can not be detected and human must manually somehow check it and allow test to continue.",
   :version=>"0.1",
   :depends=>["Mainboard", "Disk Controller", "BMC"],
   :destroys_hdd=>false,
   :is_interactive=>true,
   :poweroff_during_test=>true,
   :name=>"Firmware reflashing",
   :var=>
    {"FORCE_FIRMWARES_LIST"=>
      {:type=>"string",
       :comment=>
        "Forced firmwares list over that sended by server. Newlines replaced by twice doubledots",
       :default=>""}}},
 "net"=>
  {:description=>
    "This test must load every network interface in system and measure it's download speed. Main requirement: all network interfaces must be connected to one common network. Testing sequence is: 1) Detect and remember what interface is default (from what we are booted up (as common)); 2) Consecutively choosing each interface, check if it's MAC address doesn't exist in \"exclude macs\" test parameter, then either skip it, continuing with another one, or continue to test current inteface; 3) Bring testing interface up, configuring network on it and setting it as a default gateway; 4) Bring down all other interfaces; 5) Get test file from specified URL, measuring download speed; 6) Calculate it's checksum and compare with needed (specified by test parameter). Here, test can fail if an error occurs, otherwise it submits speed benchmarking result and continues to test remaining interfaces; 7) After all interfaces (except the first one) are tested, default interface starts testing: there is no real need in it, when we are booting from network - but it is a simplest way to restore default parameters.",
   :version=>"0.2",
   :depends=>["NIC"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Network interface",
   :var=>
    {"EXCLUDE_MAC"=>
      {:type=>"string",
       :comment=>
        "Exclude NICs with MAC addresses that match this regexp from testing",
       :default=>""},
     "TIMEOUT"=>
      {:type=>"int",
       :comment=>"Wait timeout while test file retrieving, sec",
       :default=>"15"},
     "URL"=>
      {:type=>"string",
       :comment=>"Relative to server PORT-URL to be fetched and checked",
       :default=>"3000/test_file"},
     "MD5"=>
      {:type=>"string",
       :comment=>"MD5 checksum for checking",
       :default=>"805414334eb1d3ff4fdca507ec82098f"}}},
 "whetstone"=>
  {:description=>
    "A synthetic computing benchmark that measures CPU floating-point performance. Inquisitor uses a C version and runs the specified number of loops, testing each CPU separately, with testing process running affined to particular CPU. Performance rating is in terms of MIPS.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"CPU benchmark: Whetstone",
   :var=>
    {"LOOPS"=>{:type=>"int", :comment=>"Loop count", :default=>"200000"}}},
 "stress-compress"=>
  {:description=>
    "This test runs many jobs on a hard drive simultaneously with background syncer. Each jobs performs compression/decompression together with taring/untaring of a big archive (Linux source code for example) in infinite loop. Syncer simply makes sync call each specified number of seconds. After specified time amount passed all jobs will be killed with syncer. Test will post benchmark results and successfully finish.",
   :version=>"0.1",
   :depends=>["CPU", "HDD", "Memory", "Mainboard", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Stress compression",
   :var=>
    {"STRESS_TREE"=>
      {:type=>"string",
       :comment=>"Gzipped tarball file containing stress test tree",
       :default=>"linux-stress.tar.gz"},
     "JOBS"=>
      {:type=>"int",
       :comment=>
        "Number of parallely running jobs during stress test compression/decompression",
       :default=>"16"},
     "TESTTIME"=>
      {:type=>"int",
       :comment=>"Total time of stress testing, sec",
       :default=>"600"},
     "SYNCTIME"=>
      {:type=>"int", :comment=>"Sync time period, sec", :default=>"8"}}},
 "flac-encode"=>
  {:description=>
    "This benchmark simply encodes PCM WAV audiofile to Flac format and measures encoding time.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"flac-encode",
   :var=>
    {"COMPRESSION_LEVEL"=>
      {:type=>"int",
       :comment=>"Specify compression level, between 0 (fast) and 8 (slow)",
       :default=>"8"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>"Path to PCM WAV file to compress",
       :default=>"input.wav"}}},
 "h"=>
  {:description=>
    "HDD passthrough is a stress test that imposes heavy load on main system components. First, it tries to make all HDDs present in the system to appear as separate device nodes - it checks all available RAID controllers, deletes all arrays / disk groups and creates passthrough devices to access individual HDDs if required. Second, it runs badblocks test on every available HDD, running them simulatenously in groups of 8 HDDs by default. Third, it makes a ramdisk filesystem and starts infinite compilation loop in memory, doing so with 16 simultaneous jobs (by default). Test ends successfully after both 1) minimal required stress time passes, 2) all HDDs are checked with badblocks. Test would fail if any bad blocks would be detected on any HDD. Test will usually hang or crash the system on the unstable hardware.",
   :version=>"0.3",
   :depends=>["CPU", "HDD", "Memory", "Mainboard", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD passthrough",
   :var=>
    {"STRESS_TREE"=>
      {:type=>"string",
       :comment=>"Tarball file containing stress test tree",
       :default=>"linux-stress.tar.gz"},
     "BADBLOCKS_MODE"=>
      {:type=>"string",
       :comment=>
        "Badblocks usage. Can be - read only (\"readonly\"), non-destructive read and write (\"non-destructive\"), destructive read and write (\"destructive\")",
       :default=>"readonly"},
     "JOBS"=>
      {:type=>"int",
       :comment=>
        "Number of parallely running jobs during stress test tree compile",
       :default=>"16"},
     "BADBLOCKS_BLOCKSIZE"=>
      {:type=>"int",
       :comment=>"Specify the size of blocks in bytes, bytes",
       :default=>"1024"},
     "BADBLOCKS_BLOCKS_TESTED_AT_ONCE"=>
      {:type=>"int",
       :comment=>"Number of blocks which are tested at a time.",
       :default=>"64"},
     "BADBLOCKS_PATTERN"=>
      {:type=>"string",
       :comment=>
        "Specify a test pattern to be read (and written) to disk blocks. See badblocks manual for more info.",
       :default=>""},
     "SKIP_STRESS_TESTING"=>
      {:type=>"bool",
       :comment=>"Do we need to skip stress subtest, perform only badblocks",
       :default=>"false"},
     "RAMDISK_SIZE"=>
      {:type=>"int",
       :comment=>"Size of memory disk for stress tree building, MB",
       :default=>"400"},
     "DISK_GROUP_SIZE"=>
      {:type=>"int",
       :comment=>"Number of disks per group for testing",
       :default=>"8"},
     "MINIMAL_STRESS_TIME"=>
      {:type=>"int",
       :comment=>"Minimal time of stress testing",
       :default=>"600"}}},
 "p7zip"=>
  {:description=>
    "This benchmark uses p7zip program to compress specified file in multithreaded mode with Bzip2 algorithm and measure time, which process spend on it.",
   :version=>"0.1",
   :depends=>["CPU", "Memory"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"p7zip",
   :var=>
    {"COMPRESSION_LEVEL"=>
      {:type=>"int",
       :comment=>
        "Set the compression level that reflects on testing time, from 0 (minimal) to 9 (maximal)",
       :default=>"9"},
     "THREADS"=>
      {:type=>"int",
       :comment=>
        "Force using specified number of threads. If equal to zero, then load all available CPUs",
       :default=>"0"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>"File to compress",
       :default=>"compress_file"}}},
 "bytemark"=>
  {:description=>
    "The BYTEmark benchmark test suite is used to determine how the processor, its caches and coprocessors influence overall system performance. Its measurements can indicate problems with the processor subsystem and (since the processor is a major influence on overall system performance) give us an idea of how well a given system will perform. The BYTEmark test suite is especially valuable since it lets us directly compare computers with different processors and operating systems. The code used in BYTEmark tests simulates some of the real-world operations used by popular office and technical applications. Tests include: numeric and string sort, bitfield working, fourier and assignment manipulations, huffman, IDEA, LU decomposition, neural net.",
   :version=>"0.1",
   :depends=>["CPU", "Memory", "Mainboard"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"BYTEmark benchmark suite",
   :var=>{}},
 "hdparm"=>
  {:description=>
    "This benchmark runs on all hard drives in the system sequentially. Every hard drive is benchmarked for the buffered speed and the cached speed using basic hdparm -t and -T tests for several times. The results for every HDD are averaged and presented as benchmark results.",
   :version=>"0.1",
   :depends=>["Disk Controller", "HDD"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD benchmark: Hdparm",
   :var=>
    {"AVG_SAMPLES"=>
      {:type=>"int",
       :comment=>"Number of tests per disc to average for result",
       :default=>"5"}}},
 "gprs-modem-level"=>
  {:description=>
    "This very simple benchmark intended to reset modem and send special AT-command to get signal level. As it (level) can strongly vary, human can repeat this test as much as he want.",
   :version=>"0.1",
   :depends=>["USB", "GPRS Modem"],
   :destroys_hdd=>false,
   :is_interactive=>true,
   :poweroff_during_test=>false,
   :name=>"USB GPRS modem signal level",
   :var=>
    {"LEVEL_REFERENCE_DELTA"=>
      {:type=>"int",
       :comment=>"Possible reference level variation.",
       :default=>"5"},
     "CHAT_TIMEOUT"=>
      {:type=>"int",
       :comment=>"Timeout for waiting for answer",
       :default=>"5"},
     "LEVEL_REFERENCE"=>
      {:type=>"int",
       :comment=>
        "Reference signal level. If device has equal signal strength, then test is passed. 0 value means that there is no any reference. Ask user to end test manually.",
       :default=>"0"},
     "DEV"=>
      {:type=>"string",
       :comment=>"Name of device to test",
       :default=>"/dev/ttyUSB0"}}},
 "dvb-signal-lock"=>
  {:description=>
    "This test tries to tune DVB reciever on specified transponder. It tries several times to lock signal during specified time interval. It will submit benchmark results (signal quality and strength and bit error rate) on successful finishing.",
   :version=>"0.1",
   :depends=>["DVB"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"DVB Signal Lock",
   :var=>
    {"LOCKTIME"=>
      {:type=>"int",
       :comment=>"Time to wait for tuner to lock, sec",
       :default=>"60"},
     "FEC"=>
      {:type=>"string", :comment=>"Forward error correction", :default=>"3_4"},
     "SYMBOL_RATE"=>
      {:type=>"int",
       :comment=>"Symbol rate, thousand chars/sec",
       :default=>"27500"},
     "POLARIZATION"=>
      {:type=>"string",
       :comment=>"Polarization. Horizontal or vertical",
       :default=>"horizontal"},
     "FREQUENCY"=>
      {:type=>"int", :comment=>"Frequency, kHz", :default=>"11727"}}},
 "cpu"=>
  {:description=>
    "Basic CPU burn test makes the CPUs execute instructions that rapidly increase processor's temperature in an infinite loop. Test makes special care about used instruction set (to make load as high as possible).",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"CPU burn",
   :var=>
    {"TESTTIME"=>
      {:type=>"int",
       :comment=>"Total time of CPU testing, sec",
       :default=>"1800"}}},
 "gprs-modem-dialup"=>
  {:description=>
    "Test cellular modem, connected via USB. This test tries to initialize the GPRS/EDGE/3G session using pppd with device DEV at SPEED bps, setting device's access point to APN, authenticating using username PPPD_USERNAME, selecting CHAP/PAP protocol as suggested by provider's server. You must include a relevant login/password entry in either /etc/ppp/pap-secrets or /etc/ppp/chap-secrets file for authentication to work. This test tries to reconnect pppd sessions up to PPPD_TRIES time. After successful start of pppd session, it tries to download file at URL up to DOWNLOAD_TRIES times, making sure that download takes up to DOWNLOAD_MAX_TIME seconds. Downloaded file's md5 checksum is matched MD5 string. After downloading, it tries to upload a file UPLOAD_FILE up to UPLOAD_TRIES times at UPLOAD_URL, making sure that upload takes no more than UPLOAD_MAX_TIME seconds. Both download and upload speeds are reported as benchmark results.",
   :version=>"0.2",
   :depends=>["USB", "GPRS Modem"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"USB GPRS/EDGE/3G Modem Dialup",
   :var=>
    {"URL"=>
      {:type=>"string",
       :comment=>"URL to download (without http)",
       :default=>
        "img-fotki.yandex.ru/getx/10/photoface.359/sevastopol-foto_34661_L"},
     "UPLOAD_TRIES"=>
      {:type=>"int",
       :comment=>"Number of tries to upload the file",
       :default=>"3"},
     "DOWNLOAD_TRIES"=>
      {:type=>"int",
       :comment=>"Number of tries to download the file",
       :default=>"3"},
     "PPPD_TRIES"=>
      {:type=>"int",
       :comment=>"Number of tries to bring pppd up",
       :default=>"4"},
     "UPLOAD_URL"=>
      {:type=>"string",
       :comment=>"URL to upload (without http)",
       :default=>""},
     "UPLOAD_MAX_TIME"=>
      {:type=>"int",
       :comment=>"Timeout for file upload, sec",
       :default=>"120"},
     "UPLOAD_FILE"=>
      {:type=>"string",
       :comment=>"File to upload",
       :default=>"/etc/ld.so.cache"},
     "MD5"=>
      {:type=>"string",
       :comment=>"MD5 of downloaded file",
       :default=>"ca530886183b06d0047e0655537327aa"},
     "SPEED"=>{:type=>"int", :comment=>"Line speed", :default=>"115200"},
     "DOWNLOAD_MAX_TIME"=>
      {:type=>"int",
       :comment=>"Timeout for the whole download, sec",
       :default=>"60"},
     "DEV"=>
      {:type=>"string",
       :comment=>"Name of device to test",
       :default=>"/dev/ttyUSB0"}}},
 "array-configurator"=>
  {:description=>
    "It is not a real test. Simply, it can create specified array configuration on disk controller with hard drives. Currently it either passes command line string to einarc, or (if specified \"passthrough\", \"optimal\" or \"clear\") necessary raid-wizard will be used instead.",
   :version=>"0.1",
   :depends=>["HDD", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Array configurator",
   :var=>
    {"DISK_GROUP_NUMBER"=>
      {:type=>"int",
       :comment=>"Number of disk group (for passthrough configuration)",
       :default=>"1"},
     "CONFIGURATION"=>
      {:type=>"string",
       :comment=>
        "Configuration to be passed to einarc. Can be \"clear\", \"optimal\" or \"passthrough\" to run corresponding raid-wizard utility. Otherwise it will be command line string to einarc. If there are only identical hard drives, then EINARC_DISK1, EINARC_DISK2, etc words can be used to prevent absolute hard drive's identification using",
       :default=>"optimal"},
     "ADAPTER_NUMBER"=>
      {:type=>"int",
       :comment=>"Default adapter number (-a option for einarc) to work with",
       :default=>"0"},
     "ADAPTER"=>
      {:type=>"string",
       :comment=>
        "Default adapter type to work with. Leave it empty if there only single or several identical adapters present",
       :default=>""},
     "DISK_GROUP_SIZE"=>
      {:type=>"int",
       :comment=>
        "Number of disks per group for testing (for passthrough configuration)",
       :default=>"8"}}},
 "gprs-modem"=>
  {:description=>
    "This simple test can determine connected USB modem workability. It sets modem/port speed to 115200bps, checks for proper answer on AT-commands and retrieves it's IMEI number.",
   :version=>"0.1",
   :depends=>["USB", "GPRS Modem"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"USB GPRS modem",
   :var=>
    {"CHAT_TIMEOUT"=>
      {:type=>"int",
       :comment=>"Timeout for waiting for answer",
       :default=>"5"},
     "ANSWER_ATI"=>
      {:type=>"string", :comment=>"String to get after ATI", :default=>"OK"},
     "DEV"=>
      {:type=>"string",
       :comment=>"Name of device to test",
       :default=>"/dev/ttyUSB0"}}},
 "usb-device"=>
  {:description=>
    "Tests the presence of designated USB devices. It checks for a count of USB devices that match specified idVendor and idProduct and gives a success if they're equal to COUNT parameter or failure if they're not.",
   :version=>"0.1",
   :depends=>["USB"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"USB presence",
   :var=>
    {"IDVENDOR"=>
      {:type=>"string",
       :comment=>
        "Filter in only devices with this idVendor (match all if empty, could be an extended regular expression)",
       :default=>"0403"},
     "COUNT"=>
      {:type=>"int",
       :comment=>"There should be this many devices",
       :default=>"1"},
     "IDPRODUCT"=>
      {:type=>"string",
       :comment=>
        "Filter in only devices with this idProduct (match all if empty, could be an extended regular expression)",
       :default=>"6001"}}},
 "bonnie"=>
  {:description=>
    "This test uses bonnie++ benchmark to test hard drives performance on different filesystems. For every hard drive in a system, test sequently creates specified filesystems on it and then runs bonnie++ benchmark itself. There are two sections to the program\342\200\231s operations. The first is to test the IO throughput in a fashion that is designed to simulate some types of database applications. The  second is to test creation, reading, and deleting many small files in a fashion similar to the usage patterns of programs such as Squid or INN. Bonnie++ tests some of them and for each test gives a result of the amount of work done per second and the percentage of CPU time this took. This test uses unstable Bonnie++ 1.9x version.",
   :version=>"0.2",
   :depends=>["HDD"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"HDD benchmark: Bonnie",
   :var=>
    {"FILESYSTEMS"=>
      {:type=>"string",
       :comment=>"Space-separated list of filesystems to be benchmarked",
       :default=>"ext2 ext3 vfat reiserfs xfs"},
     "MAXIMAL_FILE_SIZE"=>
      {:type=>"int", :comment=>"Maximal files size, KiB", :default=>"1024"},
     "NUMBER_OF_FILES"=>
      {:type=>"int",
       :comment=>
        "The number of files for the file creation test. This is measured in multiples of 1024 files",
       :default=>"2"},
     "DIRECTORIES_NUMBER"=>
      {:type=>"int",
       :comment=>
        "Number of directories to randomly distribute test files among them",
       :default=>"256"},
     "MINIMAL_FILE_SIZE"=>
      {:type=>"int", :comment=>"Minimal files size, KiB", :default=>"10"}}},
 "dvb-video-receive"=>
  {:description=>
    "This test makes many DVB related things. At first, it tries to tune up to transponder (with specified transponder parameters and maximum wait time (locktime)). Then it tries to find all opened available channels. Then when any of found channels can be locked up, it will make record (with specified size) of video translation there. And, after all, video's codec will be checked if it match the specified one. If everything succeed, then several benchmark results will be submited.",
   :version=>"0.1",
   :depends=>["DVB"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"DVB Video Receive",
   :var=>
    {"CODEC"=>
      {:type=>"string",
       :comment=>"Video stream must contain this video codec",
       :default=>"MPEG2"},
     "RECORD_SIZE"=>
      {:type=>"int",
       :comment=>"Recordsize for testing, KiB",
       :default=>"1024"},
     "LOCKTIME"=>
      {:type=>"int",
       :comment=>"Time to wait for locking up channel, sec",
       :default=>"60"},
     "FEC"=>
      {:type=>"string", :comment=>"Forward error correction", :default=>"3_4"},
     "SYMBOL_RATE"=>
      {:type=>"int",
       :comment=>"Symbol rate, thousand chars/sec",
       :default=>"27500"},
     "POLARIZATION"=>
      {:type=>"string",
       :comment=>"Polarization. Horizontal or vertical",
       :default=>"horizontal"},
     "FREQUENCY"=>
      {:type=>"int", :comment=>"Frequency, kHz", :default=>"11727"}}},
 "dvb-device"=>
  {:description=>
    "This test scans all DVB-capable devices and tries to figure out their MAC addresses.",
   :version=>"0.1",
   :depends=>["DVB"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"DVB Device",
   :var=>{}},
 "linpack"=>
  {:description=>
    "This test creates very high system load and monitors MCE for appearing errors. It uses Portable Implementation of the High-Performance Linpack Benchmark 2.0 for Distributed-Memory Computers and built-in MCE monitoring capabilities of Linux. Matrix size can be set by user or automatically calculated by test. Ns will be calculated to fill up nearly all available free memory. Test will submit benchmark result in gigaflops on successfull completion.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Linpack",
   :var=>
    {"MCE_CHECK_TIME"=>
      {:type=>"int", :comment=>"MCE's error check time, sec", :default=>"10"},
     "QS"=>
      {:type=>"int", :comment=>"Part of matrix size (P x Q)", :default=>"0"},
     "PS"=>
      {:type=>"int", :comment=>"Part of matrix size (P x Q)", :default=>"0"},
     "BINARY_PATH"=>
      {:type=>"string",
       :comment=>
        "Path to linpack's object code to use, that will mostly fit to your processor",
       :default=>"/usr/bin/hpl_barcelona"}}},
 "partimage"=>
  {:description=>
    "Actually this is not a real test. It can be used to write prepared raw disk image using Partimage utility.",
   :version=>"0.1",
   :depends=>["HDD", "Disk Controller"],
   :destroys_hdd=>true,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Partimage",
   :var=>
    {"COPY_TO_RAMDISK"=>
      {:type=>"bool",
       :comment=>"Copy an image to ramdisk before partimage call",
       :default=>"false"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>
        "Absolute of relative path to source raw disk image to be written",
       :default=>"raw_disk_image"},
     "TARGET"=>
      {:type=>"string",
       :comment=>"Target device name that will be overwritten",
       :default=>"sda"}}},
 "mencoder_memory"=>
  {:description=>
    "This benchmark will transcode specified input file to H.264 video, copying without modification audio in (by default) AVI container. You can specify also preset (taken from MPlayerHQ's documentation examples for x264), scaling and bitrate. Two-pass encoding option is available too. This benchmark will use x264's multithreading capabilities to load all CPUs or can run using specified number of threads.",
   :version=>"0.1",
   :depends=>["CPU", "Memory", "Mainboard", "Disk Controller", "HDD"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"Mencoder in memory",
   :var=>
    {"PRESET"=>
      {:type=>"string",
       :comment=>
        "Encoding preset. \"lq\" (low quality), \"hq\" (high quality) and \"vhq\" (very high quality) are availabe",
       :default=>"hq"},
     "SCALE"=>
      {:type=>"string",
       :comment=>"Width and height for rescaling resulting image",
       :default=>"720x480"},
     "THREADS"=>
      {:type=>"int",
       :comment=>
        "Force using specified number of threads. If equal to zero, then load all available CPUs",
       :default=>"0"},
     "BITRATE"=>
      {:type=>"int",
       :comment=>"Bitrate of resulting video, KB/sec",
       :default=>"1000"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>"Source transcoding file",
       :default=>"movie.mpeg2"},
     "TWOPASS"=>
      {:type=>"boolean",
       :comment=>"Enable two-pass encoding of not",
       :default=>"false"}}},
 "unixbench"=>
  {:description=>
    "This test is a general-purpose benchmark designed to provide a basic evaluation of the performance of a Unix-like system. It runs a set of tests to evaluate various aspects of system performance, and then generates a set of scores. Here, we are using UnixBench version 5 (multi-CPU aware branch) without 2D/3D graphics benchmarks.",
   :version=>"0.1",
   :depends=>["CPU", "Memory", "Mainboard"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"UnixBench benchmark suite",
   :var=>{}},
 "speex-encode"=>
  {:description=>
    "This benchmark simply encodes PCM WAV audiofile to Speex format and measures encoding time.",
   :version=>"0.1",
   :depends=>["CPU"],
   :destroys_hdd=>false,
   :is_interactive=>false,
   :poweroff_during_test=>false,
   :name=>"speex-encode",
   :var=>
    {"QUALITY"=>
      {:type=>"int",
       :comment=>"Specify quality, between 0 (lowest) and 10 (highest)",
       :default=>"8"},
     "VBR"=>
      {:type=>"bool", :comment=>"Enable variable bitrate", :default=>"true"},
     "SOURCE"=>
      {:type=>"string",
       :comment=>"Path to PCM WAV file to compress",
       :default=>"input.wav"},
     "DTX"=>
      {:type=>"bool",
       :comment=>"Enable file-based discontinuous transmission",
       :default=>"true"},
     "COMPLEXITY"=>
      {:type=>"int",
       :comment=>
        "Specify encoding complexity, between 0 (lowest) and 10 (highest)",
       :default=>"3"}}},
 "db_comparison"=>
  {:description=>
    "Pauses testing until hardware components comparison has been completed on the application server.",
   :version=>"0.1",
   :depends=>
    ["BMC",
     "CPU",
     "Chassis",
     "Disk Controller",
     "Floppy",
     "HDD",
     "Mainboard",
     "Memory",
     "NIC",
     "OSD",
     "Platform",
     "USB",
     "Video",
     "ODD",
     "GPRS Modem",
     "USB Mass Storage"],
   :destroys_hdd=>false,
   :is_interactive=>true,
   :poweroff_during_test=>false,
   :name=>"Datebase to detects comparison",
   :var=>{}}}

$MONITORINGS = {"cpu-vcore-ipmi"=>
  {:measurement=>"voltage",
   :description=>
    "This monitoring uses ipmitool for getting CPU's core voltage.",
   :name=>"CPU core voltage (ipmi)",
   :id=>3},
 "fan-ipmi"=>
  {:measurement=>"rpm",
   :description=>"This monitoring uses ipmitool to get Fans rotation speed.",
   :name=>"Fan rotation speed (ipmi)",
   :id=>9},
 "loadavg"=>
  {:measurement=>"load",
   :description=>
    "GNU/Linux operating system's load average. Load average figures giving the number of jobs in the run queue or waiting for disk I/O.",
   :name=>"OS load average",
   :id=>8},
 "cpu-temp-ipmi"=>
  {:measurement=>"temperature",
   :description=>
    "This monitoring uses ipmitool for getting CPU's temperature.",
   :name=>"CPU temperature (ipmi)",
   :id=>1},
 "odd-read"=>
  {:measurement=>"speed",
   :description=>
    "This is not a real monitoring: it runs only once during odd_read test, that submits drive speed. You can view actual code in client/test/odd_read in generate_speed_results function.",
   :name=>"ODD read speed",
   :id=>6},
 "thermo"=>
  {:measurement=>"temperature",
   :description=>
    "This monitoring gets all temperature measurements from FTDI-based USB thermometer.",
   :name=>"FTDI thermometer",
   :id=>7},
 "f"=>{:measurement=>nil, :description=>nil, :name=>nil, :id=>nil},
 "hdd-smart"=>
  {:measurement=>"temperature",
   :description=>
    "This monitoring uses hard drive's SMART to get its temperature.",
   :name=>"HDD temperature",
   :id=>5},
 "digitemp"=>
  {:measurement=>"temperature",
   :description=>
    "This monitoring gets all temperature measurements from 1-Wire network with Dallas thermometers",
   :name=>"DigiTemp 1-Wire thermosensors",
   :id=>10},
 "cpu-temp-sensors"=>
  {:measurement=>"temperature",
   :description=>"This monitoring uses sensors for getting CPU's temperature.",
   :name=>"CPU temperature (sensors)",
   :id=>2},
 "cpu-vcore-sensors"=>
  {:measurement=>"voltage",
   :description=>"This monitoring uses sensors for getting CPU's vcore.",
   :name=>"CPU core voltage (sensors)",
   :id=>4}}

$DETECTS = {"osd"=>
  {:description=>
    "Detect optical disk drives using hal-device and try to guess correct vendor name.",
   :depends=>["OSD"],
   :name=>"OSD detect"},
 "hdd_"=>
  {:description=>"Detect hard drives using einarc, smartctl and hal-device.",
   :depends=>["HDD"],
   :name=>"HDD detect"},
 "bmc"=>
  {:description=>"Get BMC information through ipmitool.",
   :depends=>["BMC"],
   :name=>"BMC detect"},
 "memory"=>
  {:description=>"Detect DIMMs using SPD, IPMI, DMI, /proc.",
   :depends=>["Memory"],
   :name=>"Memory detect"},
 "usb"=>
  {:description=>"Detect some devices that plugged into USB bus.",
   :depends=>["USB"],
   :name=>"USB devices detect"},
 "tape"=>
  {:description=>"Detect tape drives using hal-device.",
   :depends=>["Tape drive"],
   :name=>"Tape detect"},
 "ipmi"=>
  {:description=>"Get some devices info using ipmitool.",
   :depends=>
    ["Chassis", "Mainboard", "Platform", "Power Supply", "SCSI Backplane"],
   :name=>"IPMI parser"},
 "hdd"=>
  {:description=>"Detect hard drives using Einarc",
   :depends=>["HDD"],
   :name=>"HDD detect"},
 "controller"=>
  {:description=>
    "Detect disk controllers through einarc and hal-device with required priority.",
   :depends=>["Disk Controller"],
   :name=>"Disk controller detect"},
 "cpu"=>
  {:description=>"Detect CPUs using /proc/cpuinfo.",
   :depends=>["CPU"],
   :name=>"CPU detect"},
 "floppy"=>
  {:description=>"Detect floppy drives using hal-device.",
   :depends=>["Floppy"],
   :name=>"Floppy detect"},
 "00lshw-to-xml"=>
  {:description=>"Convert lshw output to required XML document.",
   :depends=>
    ["Video", "NIC", "FireWire (IEEE 1394)", "InfiniBand", "Fibre Channel"],
   :name=>"lshw to xml converter"},
 "bbu"=>
  {:description=>"Get BBU information through einarc.",
   :depends=>["BBU"],
   :name=>"BBU detect"}}

$SOFTWARE_DETECTS = {"iozone"=>{:description=>"Detect IOzone benchmark version.", :name=>"Iozone"},
 "linux"=>{:description=>"Detect Linux version.", :name=>"Linux"},
 "default_fs"=>
  {:description=>"Detect default filesystem.", :name=>"Default filesystem"},
 "raid"=>
  {:description=>"Detects Einarc's software RAID version.",
   :name=>"Software RAID"},
 "gas"=>{:description=>"Detect GNU assembler version.", :name=>"GAS"},
 "openssl"=>{:description=>"Detect OpenSSL tool version.", :name=>"OpenSSL"},
 "oggenc"=>
  {:description=>"Detect OGG/Vorbis encoder from Vorbis-tools version.",
   :name=>"OGGEnc"},
 "speexenc"=>
  {:description=>"Detect Speex encoder version.", :name=>"SpeexEnc"},
 "mencoder"=>
  {:description=>"Detect MEncoder encoder version.", :name=>"Mencoder"},
 "tar"=>{:description=>"Detect Tar archiver version.", :name=>"Tar"},
 "x264"=>{:description=>"Detect x264 libriary version.", :name=>"x264"},
 "gcc"=>{:description=>"Detect GCC version.", :name=>"GCC"},
 "linux_command_line"=>
  {:description=>"Detect Linux'es boot command line.",
   :name=>"Linux command line"},
 "p7zip"=>{:description=>"Detect p7zip compressor version.", :name=>"p7zip"},
 "gzip"=>{:description=>"Detect GNU Zip version.", :name=>"Gzip"},
 "bonnie"=>
  {:description=>"Detect Bonnie++ benchmark version.", :name=>"Bonnie++"},
 "flac"=>{:description=>"Detect FLAC encoder version.", :name=>"FLAC"}}

