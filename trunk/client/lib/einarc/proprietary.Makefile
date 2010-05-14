WGET=wget -q -N -P proprietary

# Special target to get proprietary download confirmation interactively
proprietary/agreed:
	@echo 'Unfortunately, Einarc uses some proprietary command-line utilities to'
	@echo 'control storages. Using it means that you agree with respective licenses'
	@echo 'and download agreements. For your convenience, they are available in'
	@echo 'agreements/ directory. Please read them and agree before proceeding.'
	@echo
	@echo 'Either type "yes" if you have read and agreed to all the respective'
	@echo 'licenses or reconfigure einarc disabling propriatery modules.'
	@echo
	@echo -n 'Do you agree? '
	@read agree && if [ "$$agree" != yes ]; then echo "Einarc can't continue unless you'll agree"; false; else mkdir -p proprietary && echo "User $$USER has agreed to all the licenses on `date`" >proprietary/agreed; fi

#===============================================================================
# Module: areca
#===============================================================================

tools/areca/cli: proprietary/v1.82_81103.zip
	mkdir -p tools/areca
	unzip -j proprietary/v1.82_81103.zip -d tools/areca
	chmod a+rx tools/areca/*
	if [ "$(TARGET)" == x86_64 ]; then \
		mv tools/areca/cli64 tools/areca/cli; \
		rm -f tools/areca/cli32; \
	else \
		mv tools/areca/cli32 tools/areca/cli; \
		rm -f tools/areca/cli64; \
	fi
	touch tools/areca/cli proprietary/v1.82_81103.zip

proprietary/v1.82_81103.zip: proprietary/agreed
	mkdir -p proprietary
	$(WGET) ftp://ftp.areca.com.tw/RaidCards/AP_Drivers/Linux/CLI/v1.82_81103.zip

#===============================================================================
# Module: lsi_megarc
#===============================================================================

tools/lsi_megarc/cli: proprietary/ut_linux_megarc_1.11.zip
	mkdir -p tools/lsi_megarc
	unzip proprietary/ut_linux_megarc_1.11.zip megarc.bin -d tools/lsi_megarc
	chmod a+rx tools/lsi_megarc/megarc.bin
	mv tools/lsi_megarc/megarc.bin tools/lsi_megarc/cli
	touch tools/lsi_megarc/cli proprietary/ut_linux_megarc_1.11.zip

proprietary/ut_linux_megarc_1.11.zip: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://www.lsi.com/DistributionSystem/AssetDocument/files/support/rsa/utilities/megaconf/ut_linux_megarc_1.11.zip

#===============================================================================
# Module: lsi_megacli
#===============================================================================

tools/lsi_megacli/cli: proprietary/8.00.16_Linux_MegaCLI.zip
	mkdir -p tools/lsi_megacli
	unzip -j proprietary/8.00.16_Linux_MegaCLI.zip -d tools/lsi_megacli
	unzip -j tools/lsi_megacli/MegaCliLin.zip -d tools/lsi_megacli
	rpm2cpio tools/lsi_megacli/MegaCli-8.00.16-1.i386.rpm | cpio -idv
	if [ "$(TARGET)" == x86_64 ]; then \
		mv opt/MegaRAID/MegaCli/MegaCli64 tools/lsi_megacli/cli; \
	else \
		mv opt/MegaRAID/MegaCli/MegaCli tools/lsi_megacli/cli; \
	fi
	rm -Rf opt tools/lsi_megacli/MegaCli-8.00.16-1.i386.rpm \
		   tools/lsi_megacli/MegaCliLin.zip \
		   tools/lsi_megacli/Lib_Utils-1.00-07.noarch.rpm \
		   tools/lsi_megacli/Lib_Utils2-1.00-01.noarch.rpm
	touch tools/lsi_megacli/cli proprietary/8.00.16_Linux_MegaCLI.zip

proprietary/8.00.16_Linux_MegaCLI.zip: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://www.lsi.com/DistributionSystem/AssetDocument/8.00.16_Linux_MegaCLI.zip

#===============================================================================
# Module: amcc
#===============================================================================

proprietary/tw_cli-linux-x86_64-9.5.0.1.tgz: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://3ware.com/download/Escalade9690SA-Series/9.5.0.1/tw_cli-linux-x86_64-9.5.0.1.tgz 

proprietary/tw_cli-linux-x86-9.5.0.1.tgz: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://3ware.com/download/Escalade9690SA-Series/9.5.0.1/tw_cli-linux-x86-9.5.0.1.tgz 

ifeq ($(TARGET), x86_64)
tools/amcc/cli: proprietary/tw_cli-linux-x86_64-9.5.0.1.tgz
	mkdir -p tools/amcc
	tar xzf proprietary/tw_cli-linux-x86_64-9.5.0.1.tgz -C tools/amcc --exclude 'tw_cli.8*'
	mv tools/amcc/tw_cli tools/amcc/cli
	# prevent repeated download/extraction
	touch tools/amcc/cli proprietary/tw_cli-linux-x86_64-9.5.0.1.tgz
else
tools/amcc/cli: proprietary/tw_cli-linux-x86-9.5.0.1.tgz
	mkdir -p tools/amcc
	tar xzf proprietary/tw_cli-linux-x86-9.5.0.1.tgz -C tools/amcc --exclude 'tw_cli.8*'
	mv tools/amcc/tw_cli tools/amcc/cli
	# prevent repeated download/extraction
	touch tools/amcc/cli proprietary/tw_cli-linux-x86_64-9.5.0.1.tgz
endif

#===============================================================================
# Module: lsi_mpt
#===============================================================================

ext/lsi_mpt.o: ext/lsi_mpt.c
	$(CC) -pipe -Wall -O2 -fPIC -I/usr/include/ruby/1.8 -I/usr/lib64/ruby/1.8/x86_64-linux-gnu -c -o ext/lsi_mpt.o ext/lsi_mpt.c

ext/lsi_mpt.so: ext/lsi_mpt.o
	$(CC) -shared -rdynamic -Wl,-export-dynamic -o ext/lsi_mpt.so ext/lsi_mpt.o -ldl -lcrypt -lm -lc -lruby

#	sh '$(WGET) http://www.lsi.com/files/support/ssp/fusionmpt/Utilities/mptutil_linux_10200.zip'

#===============================================================================
# Module: adaptec_aaccli
#===============================================================================

tools/adaptec_aaccli/cli: proprietary/Adaptec_Storage_Manager-Linux_v2.10.00.tgz
	mkdir -p tools/adaptec_aaccli
	tar -xvzf proprietary/Adaptec_Storage_Manager-Linux_v2.10.00.tgz -C tools/adaptec_aaccli
	rpm2cpio tools/adaptec_aaccli/aacapps-4.1-0.i386.rpm | cpio -idv
	rm -rf tools/adaptec_aaccli
	mkdir -p tools/adaptec_aaccli
	mv usr/sbin/aaccli tools/adaptec_aaccli/cli
	rm -rf dev usr

proprietary/Adaptec_Storage_Manager-Linux_v2.10.00.tgz: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://download.adaptec.com/raid/aac/sm/Adaptec_Storage_Manager-Linux_v2.10.00.tgz

#===============================================================================
# Module: adaptec_arcconf
#===============================================================================

ifeq ($(TARGET), x86_64)
tools/adaptec_arcconf/cli: proprietary/asm_linux_x64_v6_00_17922.rpm
	mkdir -p tools/adaptec_arcconf
	rpm2cpio proprietary/asm_linux_x64_v6_00_17922.rpm | cpio -idv
	mv usr/StorMan/arcconf tools/adaptec_arcconf/cli
	chmod a+x tools/adaptec_arcconf/cli
	rm -rf usr
else
tools/adaptec_arcconf/cli: proprietary/asm_linux_x86_v6_00_17922.rpm
	mkdir -p tools/adaptec_arcconf
	rpm2cpio proprietary/asm_linux_x86_v6_00_17922.rpm | cpio -idv
	mv usr/StorMan/arcconf tools/adaptec_arcconf/cli
	chmod a+x tools/adaptec_arcconf/cli
	rm -rf usr
endif

proprietary/asm_linux_x86_v6_00_17922.rpm: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://download.adaptec.com/raid/storage_manager/asm_linux_x86_v6_40_18530.rpm

proprietary/asm_linux_x64_v6_00_17922.rpm: proprietary/agreed
	mkdir -p proprietary
	$(WGET) http://download.adaptec.com/raid/storage_manager/asm_linux_x64_v6_40_18530.rpm
