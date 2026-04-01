# Project Name
TARGET = Tap-O-Matic

USE_DAISYSP_LGPL=1
#DEBUG=1

# Sources
CPP_SOURCES = time_machine_hardware.cpp TimeMachine.cpp

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
