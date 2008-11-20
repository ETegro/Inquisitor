Description
===========
This patch adds logging info that file has been downloaded by client.
Thus, we can be sure that client successfully downloaded it and we can
remove MAC-depending files by tftp-log-parser.

Building
========
* Downloading:
  Get tftp-hpa-0.48 from official site - http://www.kernel.org/pub/software/network/tftp/

  Current working URL is:
  http://www.kernel.org/pub/software/network/tftp/tftp-hpa-0.48.tar.gz

* Decompressing and unarchiving:
  tar xf tftp-hpa-0.48.tar.gz

* Patching with GNU's patch program:
  patch -p1 -d tftp-hpa-0.48 < tftp-hpa-0.48-inquisitor.patch

* Configuring and compiling binary:
  Make everything in tftp-hpa-0.48 directory

* Use tftp-hpa binary for serving TFTP request, logging them and using
  tftp-log-parser for deleting one-time boot images
