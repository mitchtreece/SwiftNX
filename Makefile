#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------

ifeq ($(strip $(DEVKITPRO)),)
	$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro")
endif

TOPDIR ?= $(CURDIR)
include $(DEVKITPRO)/libnx/switch_rules

#---------------------------------------------------------------------------------
# TARGET is the name of the output
# BUILD is the directory where object files & intermediate files will be placed
# SOURCES is a list of directories containing source code
# DATA is a list of directories containing data files
# INCLUDES is a list of directories containing header files
# EXEFS_SRC is the optional input directory containing data copied into exefs, if anything this normally should only contain "main.npdm".
# ROMFS is the directory containing data to be added to RomFS, relative to the Makefile (Optional)
#
# NO_ICON: if set to anything, do not use icon.
# NO_NACP: if set to anything, no .nacp file is generated.
# APP_TITLE is the name of the app stored in the .nacp file (Optional)
# APP_AUTHOR is the author of the app stored in the .nacp file (Optional)
# APP_VERSION is the version of the app stored in the .nacp file (Optional)
# APP_TITLEID is the titleID of the app stored in the .nacp file (Optional)
# ICON is the filename of the icon (.jpg), relative to the project folder.
#   If not set, it attempts to use one of the following (in this order):
#     - <Project name>.jpg
#     - icon.jpg
#     - <libnx folder>/default_icon.jpg
#---------------------------------------------------------------------------------

APP_TITLE	:= SwiftNX
APP_AUTHOR 	:= mitchtreece
APP_VERSION	:= 1.0.0

#---------------------------------------------------------------------------------

TARGET			:=	$(notdir $(CURDIR))
BUILD			:=	build
SOURCES			:=	src
DATA			:=	data
INCLUDES		:=	include
EXEFS_SRC		:=	exefs_src
ROMFS			:=	romfs

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------
ARCH		:=	-march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE

CFLAGS		:=	-g -Wall -O2 -ffunction-sections \
				`sdl2-config --cflags` `freetype-config --cflags` \
				$(ARCH) $(DEFINES)

CFLAGS		+=	$(INCLUDE) -D__SWITCH__
CXXFLAGS	:= 	$(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++11
ASFLAGS		:=	-g $(ARCH)
LDFLAGS		 =	-specs=$(DEVKITPRO)/libnx/switch.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map) -Wl,-z,nocopyreloc

LIBS		:=	-lSDL2 -lSDL2_gfx -lSDL2_ttf -lSDL2_mixer \
				-lfreetype -lz -lbz2 -lpng16 -lz -lm \
				-lpng -ljpeg -lz -lvorbisidec -logg -lmpg123 -lmodplug -lstdc++ \
				-lnx

#---------------------------------------------------------------------------------
# list of directories containing libraries, this must be the top level containing
# include and lib
#---------------------------------------------------------------------------------
LIBDIRS	:= $(PORTLIBS) $(LIBNX)

#---------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add additional
# rules for different file extensions
#---------------------------------------------------------------------------------
ifneq ($(BUILD), $(notdir $(CURDIR)))
#---------------------------------------------------------------------------------

export OUTPUT	:=	$(CURDIR)/$(TARGET)
export TOPDIR	:=	$(CURDIR)
export VPATH	:=	$(foreach dir, $(SOURCES), $(CURDIR)/$(dir)) \
					$(foreach dir, $(DATA), $(CURDIR)/$(dir))

export DEPSDIR	:=	$(CURDIR)/$(BUILD)

CFILES				:=	$(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.c)))
CPPFILES			:=	$(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.cpp)))
SFILES				:=	$(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.s)))
SWIFT_VERSION		:=	4
SWIFTAPP_NAME		:= 	app
SWIFTAPP_SRC		:=  $(DEPSDIR)/$(SWIFTAPP_NAME).swift
SWIFTAPP_LL			:= 	$(DEPSDIR)/$(SWIFTAPP_NAME).ll
SWIFTAPP_O			:= 	$(DEPSDIR)/$(SWIFTAPP_NAME).o
BINFILES			:=	$(foreach dir, $(DATA), $(notdir $(wildcard $(dir)/*.*)))

#---------------------------------------------------------------------------------
# use CXX for linking C++ projects, CC for standard C
#---------------------------------------------------------------------------------
ifeq ($(strip $(CPPFILES)),)
#---------------------------------------------------------------------------------
	export LD	:=	$(CC)
#---------------------------------------------------------------------------------
else
#---------------------------------------------------------------------------------
	export LD	:=	$(CXX)
#---------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------

export OFILES_BIN		:= 	$(addsuffix .o, $(BINFILES))
export OFILES_SRC		:= 	$(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o) $(SWIFTAPP_SRC:.swift=.o)
export OFILES 			:= 	$(OFILES_BIN) $(OFILES_SRC)
export HFILES_BIN		:= 	$(addsuffix .h, $(subst .,_,$(BINFILES)))
export INCLUDE			:= 	$(foreach dir, $(INCLUDES), -I$(CURDIR)/$(dir)) \
							$(foreach dir, $(LIBDIRS), -I$(dir)/include) \
							-I$(CURDIR)/$(BUILD)

export LIBPATHS			:=	$(foreach dir, $(LIBDIRS), -L$(dir)/lib)
export BUILD_EXEFS_SRC 	:= 	$(TOPDIR)/$(EXEFS_SRC)

ifeq ($(strip $(ICON)),)
	icons := $(wildcard *.jpg)
	ifneq (,$(findstring $(TARGET).jpg, $(icons)))
		export APP_ICON := $(TOPDIR)/$(TARGET).jpg
	else
		ifneq (,$(findstring icon.jpg, $(icons)))
			export APP_ICON := $(TOPDIR)/icon.jpg
		endif
	endif
else
	export APP_ICON := $(TOPDIR)/$(ICON)
endif

ifeq ($(strip $(NO_ICON)),)
	export NROFLAGS += --icon=$(APP_ICON)
endif

ifeq ($(strip $(NO_NACP)),)
	export NROFLAGS += --nacp=$(CURDIR)/$(TARGET).nacp
endif

ifneq ($(APP_TITLEID),)
	export NACPFLAGS += --titleid=$(APP_TITLEID)
endif

ifneq ($(ROMFS),)
	export NROFLAGS += --romfsdir=$(CURDIR)/$(ROMFS)
endif

.PHONY: $(BUILD) clean all

#---------------------------------------------------------------------------------
# Swift & build targets
#---------------------------------------------------------------------------------

# This program built for i386-apple-darwin11.3.0
# Reading makefiles...
# Updating goal targets....
#  File `all' does not exist.
#    File `/Users/mitchtreece/Developer/switch/projects/SwiftNX/SwiftNX.pfs0' does not exist.
#      File `/Users/mitchtreece/Developer/switch/projects/SwiftNX/SwiftNX.nso' does not exist.
#        File `/Users/mitchtreece/Developer/switch/projects/SwiftNX/SwiftNX.elf' does not exist.
#          File `_main.o' does not exist.
#         Must remake target `_main.o'.
# _main.c
# aarch64-none-elf-gcc -MMD -MP -MF /Users/mitchtreece/Developer/switch/projects/SwiftNX/build/_main.d -g -Wall -O2 -ffunction-sections `sdl2-config --cflags` `freetype-config --cflags` -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE    -I/Users/mitchtreece/Developer/switch/projects/SwiftNX/include  -I/opt/devkitpro/portlibs/switch/include  -I/opt/devkitpro/libnx/include -I/Users/mitchtreece/Developer/switch/projects/SwiftNX/build -D__SWITCH__ -c /Users/mitchtreece/Developer/switch/projects/SwiftNX/src/_main.c -o _main.o
#         Successfully remade target file `_main.o'.
#       Must remake target `/Users/mitchtreece/Developer/switch/projects/SwiftNX/SwiftNX.elf'.
# linking SwiftNX.elf
# aarch64-none-elf-gcc: fatal error: /opt/devkitpro/libnx/switch.specs: attempt to rename spec 'link' to already defined spec 'old_link'
# compilation terminated.
# make[1]: *** [/Users/mitchtreece/Developer/switch/projects/SwiftNX/SwiftNX.elf] Error 1
# make: *** [app] Error 2

all: main

main: $(SWIFTAPP_NAME).o
	@echo =\> Making
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

$(SWIFTAPP_NAME).o : $(SWIFTAPP_NAME).swift
	@echo =\> Creating $(SWIFTAPP_NAME).o
	swiftc -swift-version $(SWIFT_VERSION) -emit-ir -parse-as-library -I $(TOPDIR)/modules $(SWIFTAPP_SRC) -o $(SWIFTAPP_LL)
	clang --target=aarch64-arm-none-eabi -fpic -ffreestanding -Wno-override-module -o $(SWIFTAPP_O) -c $(SWIFTAPP_LL)

$(SWIFTAPP_NAME).swift: $(BUILD)
	@echo =\> Creating $(SWIFTAPP_NAME).swift
	@python $(TOPDIR)/include.py -i $(TOPDIR)/src/main.swift -o $(SWIFTAPP_SRC)

$(BUILD):
	@echo =\> Creating $(BUILD) directory
	@[ -d $@ ] || mkdir -p $@

# From libnx/switch_rules:
# %.elf:
# 	@echo linking $(notdir $@)
# 	@$(LD) $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) -o $@
# 	@$(NM) -CSn $@ > $(notdir $*.lst)
#
#	==
#	$(LD) -specs=$(DEVKITPRO)/libnx/switch.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map) -Wl,-z,nocopyreloc $(OFILES) $(LIBPATHS) $(LIBS) -o $@
#

clean:
	@echo =\> Cleaning
	@rm -fr $(BUILD) $(TARGET).pfs0 $(TARGET).nso $(TARGET).nro $(TARGET).nacp $(TARGET).elf

#---------------------------------------------------------------------------------

else
.PHONY:	all

DEPENDS := $(OFILES:.o=.d)

#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------

all	: $(OUTPUT).pfs0 $(OUTPUT).nro
$(OUTPUT).pfs0 : $(OUTPUT).nso
$(OUTPUT).nso :	$(OUTPUT).elf

ifeq ($(strip $(NO_NACP)),)
	$(OUTPUT).nro :	$(OUTPUT).elf $(OUTPUT).nacp
else
	$(OUTPUT).nro :	$(OUTPUT).elf
endif

$(OUTPUT).elf :	$(OFILES)
$(OFILES_SRC) : $(HFILES_BIN)

%.bin.o	%_bin.h : %.bin
	@echo $(notdir $<)
	@$(bin2o)

%.nxfnt.o :	%.nxfnt
	@echo $(notdir $<)
	@$(bin2o)

#---------------------------------------------------------------------------------------
-include $(DEPENDS)
#---------------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------------
# -fpic = generate position independent code. (compiles, but causes memory issues when running)
