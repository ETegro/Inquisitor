#GOTOBLAS_SRC=GotoBLAS2-1.13.tar.gz
GOTOBLAS_DIR=GotoBLAS2

#LAPACK_SRC=lapack-3.1.1.tgz

HPL_SRC=hpl-2.0.tar.gz
HPL_DIR=hpl-2.0


#tar xzf $GOTOBLAS_SRC
#cp $LAPACK_SRC $GOTOBLAS_DIR
#cd $GOTOBLAS_DIR

#patch -p1 < ../GotoBLAS.diff

#sed -i 's/# FC = gfortran/FC = gfortran/' ./Makefile.rule
#sed -i 's/# BINARY=64/BINARY=64/' ./Makefile.rule
#sed -i 's/# USE_THREAD = 0/USE_THREAD = 0/' ./Makefile.rule
#sed -i 's/# USE_OPENMP = 1/USE_OPENMP = 0/' ./Makefile.rule
#make
#cd ..


tar xzf $HPL_SRC

cp $GOTOBLAS_DIR/libgoto2.a $HPL_DIR/lib
#cp $GOTOBLAS_DIR/`readlink $GOTOBLAS_DIR/libgoto.a` $HPL_dir/lib

#cd $HPL_DIR

cat > ./$HPL_DIR/Make.inq3 <<__EOF__
SHELL        = /bin/sh
#
CD           = cd
CP           = cp
LN_S         = ln -s
MKDIR        = mkdir
RM           = /bin/rm -f
TOUCH        = touch
#
ARCH         = inq3
#
TOPdir       = `pwd`/hpl-2.0
INCdir       = \$(TOPdir)/include
BINdir       = \$(TOPdir)/bin/\$(ARCH)
LIBdir       = \$(TOPdir)/lib/\$(ARCH)
#
HPLlib       = \$(LIBdir)/libhpl.a
#
MPdir        = 
MPinc        = 
MPlib        = 
#
LAdir        = 
LAinc        =
LAlib        = \$(TOPdir)/lib/libgoto2.a
#
F2CDEFS      = -DAdd__ -DF77_INTEGER=int -DStringSunStyle
#
HPL_INCLUDES = -I\$(INCdir) -I\$(INCdir)/\$(ARCH) \$(LAinc) \$(MPinc)
HPL_LIBS     = \$(HPLlib) \$(LAlib) \$(MPlib)
#
HPL_OPTS     =
# 
# ----------------------------------------------------------------------
#
HPL_DEFS     = \$(F2CDEFS) \$(HPL_OPTS) \$(HPL_INCLUDES) 
#
CC           = mpicc
CCNOOPT      = \$(HPL_DEFS)
CCFLAGS      = \$(HPL_DEFS) -fomit-frame-pointer -O3 -funroll-loops -W -Wall
#
LINKER       = mpif77
LINKFLAGS    = \$(CCFLAGS)
#
ARCHIVER     = ar
ARFLAGS      = r
RANLIB       = echo
#
# ----------------------------------------------------------------------
__EOF__

make -C $HPL_DIR arch=inq3
#cd ..
cp $HPL_DIR/bin/inq3/xhpl ./
