PROGRAM_NAME = postfix
CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
OC=arm-none-eabi-objcopy
LD=arm-none-eabi-ld
LIBS = libs
SRC = src
OBJ = obj
CFLAGS += -g -ffreestanding -c
AFLAGS += -g 

default: $(OBJ)/$(PROGRAM_NAME)
# Files the target depends on 
DEPS = $(SRC)/main.o $(LIBS)/boot.o  $(LIBS)/yOS.o

# Assemble assembly files
$(SRC)/%.o: $(SRC)/%.s
	$(AS) $(AFLAGS) $< -o $@
$(LIBS)/%.o: $(LIBS)/%.s
	$(AS) $(AFLAGS) $< -o $@

# Link all
$(OBJ)/$(PROGRAM_NAME).elf: $(DEPS)
	$(LD) -T libs/linker.ld --start-group $(DEPS) --end-group -o $(OBJ)/$(PROGRAM_NAME).elf

# To create a hex file if needed
$(OBJ)/$(PROGRAM_NAME): $(OBJ)/$(PROGRAM_NAME).elf
	$(OC) $< $@.hex -Oihex
clean:
	rm -f */*.o */*~ $(OBJ)/*
