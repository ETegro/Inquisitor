Description
===========
This patch disables checking of network addresses that preserves peer
exchange in local networks (192.168/16, etc).

Building
========
* Downloading:
  Get BNBT tracker - 20060727-bnbt85

  Current working URL is:
  http://ftp.ncnu.edu.tw/FreeBSD/distfiles/20060727-bnbt85-src.tar.gz

* Decompressing and unarchiving:
  tar xf 20060727-bnbt85-src.tar.gz

* Patching with GNU's patch program:
  patch -d 20060727-bnbt85-src < 20060727-bnbt85-src-inquisitor.patch

* Configuring and compiling binary:
  Make everything in 20060727-bnbt85-src directory

* Use bnbt binary for tracking your torrents for torrent-upload test
