
# MPI Compiler
CC=mpicc

BUILD_DIR := build

all: execute_0

build_0: 0-measure-latency/src/measure_latency.c | $(BUILD_DIR)
	$(CC) 0-measure-latency/src/measure_latency.c -o $(BUILD_DIR)/0_measure_latency.out

execute_0: build_0 | $(BUILD_DIR)
	mpirun -np 2 $(BUILD_DIR)/0_measure_latency.out

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clear:
	rm build/