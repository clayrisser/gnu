# File: /main.mk
# Project: mkgnu
# File Created: 03-10-2021 22:03:16
# Author: Clay Risser
# -----
# Last Modified: 03-10-2021 22:54:23
# Modified By: Clay Risser
# -----
# BitSpur Inc (c) Copyright 2021
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifneq ($(NIX_ENV),true)
	ifeq ($(PLATFORM),darwin)
		export FIND ?= $(call ternary,gfind --version,gfind,find)
		export GREP ?= $(call ternary,ggrep --version,ggrep,grep)
		export SED ?= $(call ternary,gsed --version,gsed,sed)
	endif
endif
ifeq (,$(SED))
	ifneq ($(call ternary,sed --version,true,false),true)
		ifeq ($(PLATFORM),win32)
			SED_DOWNLOAD ?= https://bitbucket.org/xoviat/chocolatey-packages/raw/4ce05f43ec7fcb21be34221c79198df3aae81f54/sed/4.8/tools/install/sed-windows-master/sed-4.8-x64.exe
			export SED := $(HOMEPATH)\.mkpm\bin\sed.exe
		endif
	endif
endif
ifeq (,$(GREP))
	ifneq ($(call ternary,grep --version,true,false),true)
		ifeq ($(PLATFORM),win32)
			GREP_DOWNLOAD ?= https://bitbucket.org/xoviat/chocolatey-packages/raw/4ce05f43ec7fcb21be34221c79198df3aae81f54/grep/2.10.05082020/tools/install/bin/grep.exe
			export GREP := $(HOMEPATH)\.mkpm\bin\grep.exe
			LIBICONV_DLL_DOWNLOAD ?= https://bitbucket.org/xoviat/chocolatey-packages/raw/4ce05f43ec7fcb21be34221c79198df3aae81f54/grep/2.10.05082020/tools/install/bin/libiconv-2.dll
			LIBICONV_DLL := $(HOMEPATH)\.mkpm\bin\libiconv-2.dll
			LIBINTL_DLL_DOWNLOAD ?= https://bitbucket.org/xoviat/chocolatey-packages/raw/4ce05f43ec7fcb21be34221c79198df3aae81f54/grep/2.10.05082020/tools/install/bin/libintl-8.dll
			LIBINTL_DLL := $(HOMEPATH)\.mkpm\bin\libintl-8.dll
			LIBPCRE_DLL_DOWNLOAD ?= https://bitbucket.org/xoviat/chocolatey-packages/raw/4ce05f43ec7fcb21be34221c79198df3aae81f54/grep/2.10.05082020/tools/install/bin/libpcre-0.dll
			LIBPCRE_DLL := $(HOMEPATH)\.mkpm\bin\libpcre-0.dll
		endif
	endif
endif
ifeq (,$(FIND))
	ifneq ($(call ternary,find --version,true,false),true)
		FIND_DOWNLOAD ?= https://sourceforge.net/projects/ezwinports/files/findutils-4.2.30-5-w32-bin.zip/download
		export FIND := $(HOMEPATH)\.mkpm\find\bin\find.exe
	endif
endif
export AWK ?= awk
export CD ?= cd
export GREP ?= grep
export JQ ?= jq
export READLINE ?= readline
export SED ?= sed
export TAR ?= tar
export TIME ?= time

# COREUTILS
export BASENAME ?= basename
export CAT ?= cat
export CHMOD ?= chmod
export CHOWN ?= chown
export CHROOT ?= chroot
export COMM ?= comm
export CP ?= cp
export CUT ?= cut
export DATE ?= date
export DD ?= dd
export DF ?= df
export DIRNAME ?= dirname
export DU ?= du
export ECHO ?= echo
export ENV ?= env
export EXPAND ?= expand
export FALSE ?= false
export FMT ?= fmt
export FOLD ?= fold
export GROUPS ?= groups
export HEAD ?= head
export HOSTNAME ?= hostname
export ID ?= id
export JOIN ?= join
export LN ?= ln
export LS ?= ls
export MD5SUM ?= md5sum
export MKDIR ?= mkdir
export MV ?= mv
export NICE ?= nice
export PASTE ?= paste
export PR ?= pr
export PRINTF ?= printf
export PWD ?= pwd
export RM ?= rm
export RMDIR ?= rmdir
export SEQ ?= seq
export SLEEP ?= sleep
export SORT ?= sort
export SPLIT ?= split
export SU ?= su
export TAIL ?= tail
export TEE ?= tee
export TEST ?= test
export TOUCH ?= touch
export TR ?= tr
export TRUE ?= true
export UNAME ?= uname
export UNEXPAND ?= unexpand
export UNIQ ?= uniq
export WC ?= wc
export WHO ?= who
export WHOAMI ?= whoami
export YES ?= yes

# FINDUTILS
export FIND ?= find
export LOCATE ?= locate
export UPDATEDB ?= updatedb
export XARGS ?= xargs

# PROCPS
export KILL ?= kill
export PS ?= ps
export TOP ?= top

# INFOZIP
export zip ?= zip
export unzip ?= unzip

-include $(MKPM)/.mkgnu
$(MKPM)/.mkgnu:
ifneq (,$(GREP_DOWNLOAD))
ifeq ($(SHELL),cmd.exe)
	@$(GREP) --version $(NOOUT) || ( \
		$(DOWNLOAD) $(GREP) $(GREP_DOWNLOAD) && \
		$(DOWNLOAD) $(LIBICONV_DLL) $(LIBICONV_DLL_DOWNLOAD) && \
		$(DOWNLOAD) $(LIBINTL_DLL) $(LIBINTL_DLL_DOWNLOAD) && \
		$(DOWNLOAD) $(LIBPCRE_DLL) $(LIBPCRE_DLL_DOWNLOAD) \
	)
else
	@$(GREP) --version $(NOOUT) || ( \
		$(DOWNLOAD) $(GREP) $(GREP_DOWNLOAD) && \
		$(CHMOD) +x $(GREP) $(NOFAIL) \
	)
endif
endif
ifneq (,$(FIND_DOWNLOAD))
ifeq ($(SHELL),cmd.exe)
	@$(call mkdir_p,$(HOME)/.mkpm/find)
	@$(FIND) --version $(NOOUT) || ( \
		$(DOWNLOAD) "$(HOME)/.mkpm/find/find.zip" $(FIND_DOWNLOAD) && \
		$(CD) "$(HOME)/.mkpm/find" && \
		$(TAR) -xzf "$(HOME)/.mkpm/find/find.zip" && \
		$(call rm_rf,"$(HOME)/.mkpm/find/find.zip") \
	)
else
	@$(FIND) --version $(NOOUT) || ( \
		$(DOWNLOAD) $(FIND) $(FIND_DOWNLOAD) && \
		$(CHMOD) +x $(FIND) $(NOFAIL) \
	)
endif
endif
ifneq (,$(SED_DOWNLOAD))
	@$(SED) --version $(NOOUT) || ( \
		$(DOWNLOAD) $(SED) $(SED_DOWNLOAD) && \
		$(CHMOD) +x $(SED) $(NOFAIL) \
	)
endif
	@$(call mkdir_p,$(@D))
	@$(call touch_m,$@)
