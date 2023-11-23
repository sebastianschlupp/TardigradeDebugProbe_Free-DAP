##############################################################################
BUILD = build
BIN = TM-dap

ifdef GNUARMEMB_TOOLCHAIN_PATH
	COMP_PATH := $(GNUARMEMB_TOOLCHAIN_PATH)
else
	COMP_PATH := /Applications/ARMGNUToolchain/13.2.Rel1/arm-none-eabi/bin
endif
##############################################################################
.PHONY: all directory clean size

CC = $(COMP_PATH)/arm-none-eabi-gcc
OBJCOPY = $(COMP_PATH)/arm-none-eabi-objcopy
SIZE = $(COMP_PATH)/arm-none-eabi-size

ifeq ($(OS), Windows_NT)
	MKDIR = gmkdir
else
	MKDIR = mkdir
endif

CFLAGS += -W -Wall -Wextra --std=gnu11 -Os
CFLAGS += -fno-diagnostics-show-caret
CFLAGS += -fdata-sections -ffunction-sections
CFLAGS += -funsigned-char -funsigned-bitfields
CFLAGS += -mcpu=cortex-m0plus -mthumb
CFLAGS += -MD -MP -MT $(BUILD)/$(*F).o -MF $(BUILD)/$(@F).d
CFLAGS += -flto

LDFLAGS += -mcpu=cortex-m0plus -mthumb
LDFLAGS += -Wl,--gc-sections
LDFLAGS += -Wl,--script=./linker/samd21j18.ld
LDFLAGS += -flto

INCLUDES += \
  -I./include \
  -I../.. \
  -I.

SRCS += \
  ../free-dap/dap.c \
  ./main.c \
  ./udc.c \
  ./usb.c \
  ./usb_descriptors.c \
  ./startup_samd21.c

DEFINES += \
  -D__SAMD21J18A__ \
  -DDONT_USE_CMSIS_INIT \
  -DF_CPU=48000000

CFLAGS += $(INCLUDES) $(DEFINES)

OBJS = $(addprefix $(BUILD)/, $(notdir %/$(subst .c,.o, $(SRCS))))

all: directory $(BUILD)/$(BIN).elf $(BUILD)/$(BIN).hex $(BUILD)/$(BIN).bin size

$(BUILD)/$(BIN).elf: $(OBJS)
	@echo LD $@
	@$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o $@

$(BUILD)/$(BIN).hex: $(BUILD)/$(BIN).elf
	@echo OBJCOPY $@
	@$(OBJCOPY) -O ihex $^ $@

$(BUILD)/$(BIN).bin: $(BUILD)/$(BIN).elf
	@echo OBJCOPY $@
	@$(OBJCOPY) -O binary $^ $@

%.o:
	@echo CC $@
	@$(CC) $(CFLAGS) $(filter %/$(subst .o,.c,$(notdir $@)), $(SRCS)) -c -o $@

directory:
	@$(MKDIR) -p $(BUILD)

size: $(BUILD)/$(BIN).elf
	@echo size:
	@$(SIZE) -t $^

clean:
	@echo clean
	@-rm -rf $(BUILD)

-include $(wildcard $(BUILD)/*.d)
