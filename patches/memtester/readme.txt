Description
===========
This patch adds new command line option that enables quiet mode. We
are using redirection of memtester's output to temporary file in
memory, that can significantly grow without quiet mode.

Building
========
* Downloading:
  Get memtester-4.0.8 from official site - http://pyropus.ca/software/memtester/

  Current working URL is:
  http://pyropus.ca/software/memtester/old-versions/memtester-4.0.8.tar.gz

* Decompressing and unarchiving:
  tar xf memtester-4.0.8.tar.gz

* Patching with GNU's patch program:
  patch -d memtester-4.0.8 < memtester-4.0.8-inquisitor.patch

* Configuring and compiling binary:
  Make everything in memtester-4.0.8 directory

* Copy memtester binary to /usr/bin/ in Inquisitor's client chroot
