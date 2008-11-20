Description
===========
This patch adds new command line option that disables checking of
output (to be written and/or created) files. That gives ability to
use raw block devices.

Building
========
* Downloading:
  Get ctorrent-dnh3.3.2 from official site - http://www.rahul.net/dholmes/ctorrent/

  Current working URL is:
  http://downloads.sourceforge.net/dtorrent/ctorrent-dnh3.3.2.tar.gz

* Decompressing and unarchiving:
  tar xf ctorrent-dnh3.3.2.tar.gz

* Patching with GNU's patch program:
  patch -d ctorrent-dnh3.3.2 < dtorrent-3.3.2-inquisitor.patch

* Configuring and compiling binary:
  Make everything in ctorrent-dnh3.3.2 directory

* Copy ctorrent binary to /usr/bin/ in Inquisitor's client chroot
