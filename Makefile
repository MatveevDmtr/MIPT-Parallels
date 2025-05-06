
# MPI Compiler
CC=mpicc

BUILD_DIR := build

all: execute_0 execute_1

# Measure latency
build_0: 0-measure-latency/src/measure_latency.c | $(BUILD_DIR)
	$(CC) 0-measure-latency/src/measure_latency.c -o $(BUILD_DIR)/0_measure_latency.out

execute_0: build_0 | $(BUILD_DIR)
	mpirun -np 2 $(BUILD_DIR)/0_measure_latency.out

# Calculate pi
build_1: 1-calc-pi/src/pi_calculation.c | $(BUILD_DIR)
	$(CC) 1-calc-pi/src/pi_calculation.c -o $(BUILD_DIR)/1_calc_pi.out

execute_1: build_1 | $(BUILD_DIR)
	mpirun -np 16 $(BUILD_DIR)/1_calc_pi.out


$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clear:
	rm build/