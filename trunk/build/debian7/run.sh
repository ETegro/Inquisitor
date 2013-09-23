#!/bin/bash -x

. ${DIR}/config

function clean() {
	cd $LIVEDIR
	lb clean
}

function build() {
	mkdir -p $LIVEDIR
	cd $LIVEDIR
	lb config \
		--bootstrap debootstrap \
		--system live
	sed s/PLATFORM/$ARCH/g < ../config.bootstrap > ../bootstrap.1
	sed s/DEB_DISTR/$DEB_VERSION/g < ../bootstrap.1 > config/bootstrap
	rm -f ../bootstrap.1
	mkdir -p $BUILDDIR
	cd $BUILDDIR
	cp -rv ../packages $BUILDDIR/
#	for i in `ls ${BUILDDIR}/packages/`; do
#		cd ${BUILDDIR}/packages/${i}
#		dpkg-buildpackage
#    done

# 
}
