CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g

BUILD_DIR = build
BIN_DIR = bin

TARGET = $(BIN_DIR)/dynarray_test
SRCS = dynarray.c dynarray_test.c
OBJS = $(SRCS:%.c=$(BUILD_DIR)/%.o)

all: $(TARGET)

$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: %.c dynarray.h | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

.PHONY: all clean
