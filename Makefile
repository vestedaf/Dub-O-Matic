# Project Name
# A is built from the firmware-A-baseline git tag.
# This Makefile builds B (default) and C from current sources.
FIRMWARE_VARIANT ?= B

ifeq ($(FIRMWARE_VARIANT),C)
TARGET = Dub-O-Matic-C
CPPFLAGS += -DFW_VARIANT_C=1
else
TARGET = Dub-O-Matic-B
endif

USE_DAISYSP_LGPL=1
#DEBUG=1

# Sources
CPP_SOURCES = dub_machine_hardware.cpp DubMachine.cpp

# Pulling in float printf support costs several KB of flash.
# Keep it opt-in so release builds still fit after the reverb addition.
ENABLE_FLOAT_PRINTF ?= 0
ifeq ($(ENABLE_FLOAT_PRINTF),1)
LDFLAGS += -u _printf_float
endif

OPT = -Os

# Library Locations
LIBDAISY_DIR = ../DaisyExamples/libDaisy/
DAISYSP_DIR = ../DaisyExamples/DaisySP/

# Core location, and generic Makefile.
SYSTEM_FILES_DIR = $(LIBDAISY_DIR)/core
include $(SYSTEM_FILES_DIR)/Makefile
