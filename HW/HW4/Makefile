SRC_DIR := src
SOURCES := $(shell find $(SRC_DIR)/*.v -type f)
TEST_DIR := test
TEST_SOURCE := $(TEST_DIR)/regfile.t.v
EXEC_DIR := bin
TEST_TARGET := $(EXEC_DIR)/test

test: $(TEST_TARGET)
	vvp $<

$(TEST_TARGET): $(TEST_SOURCE) $(SOURCES)
	iverilog -o $@ $^ -Wall

clean:
	find $(EXEC_DIR) -type f -exec rm {} +

.PHONY: test clean
