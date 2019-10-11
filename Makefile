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
#
# CONFIG_JSON is the filename of the NPDM config file (.json), relative to the project folder.
#   If not set, it attempts to use one of the following (in this order):
#     - <Project name>.json
#     - config.json
#   If a JSON file is provided or autodetected, an ExeFS PFS0 (.nsp) is built instead
#   of a homebrew executable (.nro). This is intended to be used for sysmodules.
#   NACP building is skipped as well.
#---------------------------------------------------------------------------------

APP_TITLE 		:= SwiftNX
APP_AUTHOR		:= mitchtreece
APP_VERSION		:= 1.0.0

#---------------------------------------------------------------------------------

TARGET			:= $(notdir $(CURDIR))
BUILD			:= build
SOURCES			:= src
DATA			:= data
INCLUDES		:= include
# ROMFS			 := romfs

#---------------------------------------------------------------------------------
# dev environment
#---------------------------------------------------------------------------------

DEVELOPER		:= /Library/Developer

#---------------------------------------------------------------------------------
# swift environment
#---------------------------------------------------------------------------------

SWIFT_VERSION				:= 5
SWIFT_TOOLCHAIN_VERSION 	:= arm64-5.1.0-RELEASE
SWIFT_TOOLCHAIN 			:= $(DEVELOPER)/Toolchains/$(SWIFT_TOOLCHAIN_VERSION).xctoolchain
SWIFT_SDK					:= $(DEVELOPER)/SDKs/$(SWIFT_TOOLCHAIN_VERSION).sdk
SWIFT_TOOLS					:= $(SWIFT_TOOLCHAIN)/usr/bin
SWIFT_CLANG					:= $(SWIFT_TOOLS)/clang
SWIFTC 						:= $(SWIFT_TOOLS)/swiftc

#---------------------------------------------------------------------------------
# devkitpro tools
#---------------------------------------------------------------------------------

DKP_BIN			:= $(DEVKITPRO)/devkitA64/bin
DKP_GCC			:= $(DKP_BIN)/aarch64-none-elf-gcc
DKP_GPP			:= $(DKP_BIN)/aarch64-none-elf-g++
DKP_ELF2NRO		:= $(DEVKITPRO)/tools/bin/elf2nro

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------

CPU	 			:= cortex-a57
ARCH_BASE 		:= armv8
ARCH_SUB		:= a
ARCH 			:= -march=$(ARCH_BASE)-$(ARCH_SUB)+crc+crypto -mtune=$(CPU) -mtp=soft -fPIE

CFLAGS 			:= -v -g -Wall -O2 -ffunction-sections \
				   $(ARCH) $(DEFINES)

				   # `sdl2-config --cflags` `freetype-config --cflags` \ #

CFLAGS 			+= $(INCLUDE) -D__SWITCH__
CXXFLAGS 		:= $(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++11

ASFLAGS 		:= -g $(ARCH)
LDFLAGS		 	 = -v -specs=$(DEVKITPRO)/libnx/switch.specs -g $(ARCH) \
				   -Wl,-Map,$(notdir $*.map) -Wl,-z,nocopyrelo

LIBS 			:= -lnx

# LIBS 			 :=	-lSDL2 -lSDL2_gfx -lSDL2_ttf -lSDL2_mixer \
# 			 		-lfreetype -lz -lbz2 -lpng16 -lm \
# 					-lpng -ljpeg -lvorbisidec -logg -lmpg123 -lmodplug -lstdc++ \
# 					-lnx

#---------------------------------------------------------------------------------
# list of directories containing libraries, this must be the top level containing
# include and lib
#---------------------------------------------------------------------------------

LIBDIRS			:= $(PORTLIBS) $(LIBNX)

#---------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add additional
# rules for different file extensions
#---------------------------------------------------------------------------------
ifneq ($(BUILD), $(notdir $(CURDIR)))
#---------------------------------------------------------------------------------

export OUTPUT 		:= $(CURDIR)/$(TARGET)
export TOPDIR		:= $(CURDIR)
export VPATH		:= $(foreach dir, $(SOURCES), $(CURDIR)/$(dir)) \
				   	   $(foreach dir, $(DATA), $(CURDIR)/$(dir))

export SOURCE_DIR 	:= $(TOPDIR)/$(SOURCES)
export BUILD_DIR 	:= $(TOPDIR)/$(BUILD)

SWIFTAPP_NAME	:= app
CFILES			:= $(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.c)))
CPPFILES		:= $(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.cpp)))
SFILES			:= $(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.s)))
SWIFTFILES		:= $(foreach dir, $(SOURCES), $(notdir $(wildcard $(dir)/*.swift)))
BINFILES		:= $(foreach dir, $(DATA), $(notdir $(wildcard $(dir)/*.*)))

#---------------------------------------------------------------------------------
# use CXX for linking C++ projects, CC for standard C
#---------------------------------------------------------------------------------
ifeq ($(strip $(CPPFILES)),)
#---------------------------------------------------------------------------------
	export LD	:= $(CC)
#---------------------------------------------------------------------------------
else
#---------------------------------------------------------------------------------
	export LD	:= $(CXX)
#---------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------

export OFILES_BIN 		:= $(addsuffix .o, $(BINFILES))
export OFILES_SRC		:= $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o) $(SWIFTFILES:.swift=.o)
export OFILES 			:= $(OFILES_BIN) $(OFILES_SRC)
export HFILES_BIN		:= $(addsuffix .h, $(subst .,_,$(BINFILES)))
export INCLUDE			:= $(foreach dir, $(INCLUDES), -I$(CURDIR)/$(dir)) \
						   $(foreach dir, $(LIBDIRS), -I$(dir)/include) \
						   -I$(BUILD_DIR)

export LIBPATHS			:= $(foreach dir, $(LIBDIRS), -L$(dir)/lib)
export BUILD_EXEFS_SRC 	:= $(TOPDIR)/$(EXEFS_SRC)

ifeq ($(strip $(CONFIG_JSON)),)
	jsons := $(wildcard *.json)
	ifneq (,$(findstring $(TARGET).json,$(jsons)))
		export APP_JSON := $(TOPDIR)/$(TARGET).json
	else
		ifneq (,$(findstring config.json,$(jsons)))
			export APP_JSON := $(TOPDIR)/config.json
		endif
	endif
else
	export APP_JSON := $(TOPDIR)/$(CONFIG_JSON)
endif

ifeq ($(strip $(ICON)),)
	icons := $(wildcard *.jpg)
	ifneq (,$(findstring $(TARGET).jpg,$(icons)))
		export APP_ICON := $(TOPDIR)/$(TARGET).jpg
	else
		ifneq (,$(findstring icon.jpg,$(icons)))
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
	export NROFLAGS += --nacp=$(TOPDIR)/$(TARGET).nacp
endif

ifneq ($(APP_TITLEID),)
	export NACPFLAGS += --titleid=$(APP_TITLEID)
endif

ifneq ($(ROMFS),)
	export NROFLAGS += --romfsdir=$(TOPDIR)/$(ROMFS)
endif

.PHONY: $(BUILD) clean all

#---------------------------------------------------------------------------------
# Swift & build targets
#---------------------------------------------------------------------------------

all: main

$(BUILD):
	@echo → Creating $(BUILD) directory
	@[ -d $@ ] || mkdir -p $@

# $(SWIFTAPP_NAME).swift: $(BUILD)
# 	@echo → Creating $(SWIFTAPP_NAME).swift
# 	@python $(TOPDIR)/include.py -i $(SOURCE_DIR)/main.swift -o $(BUILD_DIR)/$(SWIFTAPP_NAME).swift

main: $(BUILD)
	@echo → Making $(OFILES)
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(TOPDIR)/Makefile

clean:
	@echo → Cleaning
ifeq ($(strip $(APP_JSON)),)
	@rm -fr $(BUILD) $(TARGET).nro $(TARGET).nacp $(TARGET).elf
else
	@rm -fr $(BUILD) $(TARGET).nsp $(TARGET).nso $(TARGET).npdm $(TARGET).elf
endif

# $(SWIFTAPP_NAME).ll : $(SWIFTAPP_NAME).swift
# 	@echo → Creating $(SWIFTAPP_NAME).ll
#
# 	$(SWIFTC) -v -swift-version $(SWIFT_VERSION) -sdk $(SWIFT_SDK) -tools-directory $(SWIFT_TOOLS) -target aarch64-unknown-linux \
# 	-emit-ir -parse-as-library \
# 	$(BUILD_DIR)/$(SWIFTAPP_NAME).swift -o $(BUILD_DIR)/$(SWIFTAPP_NAME).ll
#
# $(SWIFTAPP_NAME).o : $(SWIFTAPP_NAME).ll
# 	@echo → Creating $(SWIFTAPP_NAME).o
#
# 	$(SWIFT_CLANG) -target aarch64-none-eabi -ffreestanding -Wno-override-module \
# 	-c $(BUILD_DIR)/$(SWIFTAPP_NAME).ll -o $(BUILD_DIR)/$(SWIFTAPP_NAME).o

# $(SWIFTAPP_NAME).elf : $(SWIFTAPP_NAME).o
# 	@echo → Creating $(SWIFTAPP_NAME).elf
#
# 	$(DKP_BIN)/$(LD) $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) \
# 	$(BUILD_DIR)/$(SWIFTAPP_NAME).o -o $(BUILD_DIR)/$(SWIFTAPP_NAME).elf
#
# 	@$(NM) -CSn $(BUILD_DIR)/$(SWIFTAPP_NAME).elf > $(notdir $*.lst)
#
# $(SWIFTAPP_NAME).nro : $(SWIFTAPP_NAME).elf
# 	@echo → Creating $(SWIFTAPP_NAME).nro
# 	$(ELF2NRO) $(BUILD_DIR)/$(SWIFTAPP_NAME).elf $(BUILD_DIR)/$(SWIFTAPP_NAME).nro
#
# main: $(SWIFTAPP_NAME).nro
# 	@echo → Done
#
# $(SWIFTAPP_NAME).o : $(SWIFTAPP_NAME).swift
# 	@echo =\> Creating $(SWIFTAPP_NAME).o
#
# 	$(SWIFTC) -v -swift-version $(SWIFT_VERSION) -sdk $(SWIFT_SDK) -tools-directory $(SWIFT_TOOLS) -target aarch64-unknown-linux \
# 	-I$(SWIFT_SDK)/usr/include -I$(SWIFT_SDK)/usr/include/aarch64-linux-gnu \
# 	-L$(SWIFT_TOOLCHAIN)/usr/lib/swift/linux -L$(SWIFT_TOOLCHAIN)/usr/lib/swift_static/linux \
# 	-lswiftCore -lswiftGlibc -lswiftSwiftOnoneSupport -lswiftDispatch -lBlocksRuntime -lFoundation \
# 	-use-ld=gold -emit-object -static-stdlib -parse-as-library \
# 	$(SWIFTAPP_SRC) -o $(SWIFTAPP_O)
#
# main: $(SWIFTAPP_NAME).o
# 	@echo =\> Building
# 	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

#---------------------------------------------------------------------------------

else
.PHONY:	all

DEPENDS := $(OFILES:.o=.d)

#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------

ifeq ($(strip $(APP_JSON)),)
all	: $(OUTPUT).nro

ifeq ($(strip $(NO_NACP)),)
$(OUTPUT).nro : $(OUTPUT).elf $(OUTPUT).nacp
else
$(OUTPUT).nro :	$(OUTPUT).elf
endif

else

all	: $(OUTPUT).nsp
$(OUTPUT).nsp :	$(OUTPUT).nso $(OUTPUT).npdm
$(OUTPUT).nso :	$(OUTPUT).elf

endif

$(OUTPUT).elf : $(OFILES)
$(OFILES_SRC) : $(HFILES_BIN)

%.o : %.swift
	@echo → Swift -- $@

	$(SWIFTC) -v -swift-version $(SWIFT_VERSION) -sdk $(SWIFT_SDK) -tools-directory $(SWIFT_TOOLS) -target aarch64-unknown-linux \
	-emit-ir -parse-as-library \
	-I$(TOPDIR)/modules \
	$< -o ${@:.o=}.ll

	$(SWIFT_CLANG) -target aarch64-none-eabi -ffreestanding -Wno-override-module \
	-c ${@:.o=}.ll -o $@

%.bin.o	%_bin.h : %.bin
	@echo $(notdir $<)
	@$(bin2o)

-include $(DEPENDS)

#---------------------------------------------------------------------------------------

endif

# NOTES --------------------------------------------------------------------------------
# clang target: aarch64-arm-none-eabi (arch-vendor-os-env)
# --target=$(ARCH_BASE)-none-eabi
# -fpic = generate position independent code. (compiles, but causes memory issues when running)

# clang:
# $(SWIFT_TOOLS)/clang -v --target=aarch64-unknown-linux -mcpu=$(CPU) \
# -fuse-ld=gold -ffreestanding -Wno-override-module -fpic \
# -L$(SWIFT_TOOLCHAIN)/usr/lib/swift_static/linux \
# -lswiftCore -lswiftGlibc -lswiftSwiftOnoneSupport -lswiftDispatch -lBlocksRuntime -lFoundation \
# -o $(SWIFTAPP_O) -c $(SWIFTAPP_LL)
