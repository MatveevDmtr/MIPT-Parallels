
# MPI Compiler
CC=mpicc

EXT_FLAGS= -lm

BUILD_DIR := build

all: execute_0 execute_1 execute_2

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

# Transport equation
build_2: 2-transport-eq/src/main.c 2-transport-eq/src/transport_equation.c | $(BUILD_DIR)
	$(CC) 2-transport-eq/src/main.c 2-transport-eq/src/transport_equation.c $(EXT_FLAGS) -o $(BUILD_DIR)/2_transport_eq.out

execute_2: build_2 | $(BUILD_DIR)
	mpirun -np 16 $(BUILD_DIR)/2_transport_eq.out


$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clear:
	rm build/