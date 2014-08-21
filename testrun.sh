#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

# Get the arguments.
CONFIG_ID=$1		# String identifier for the system configuration, e.g. "foo" sans quotes
L1_MODE=$2 			# String identifier for the DPCS mode in L1: vanilla static or dynamic
L2_MODE=$3			# String identifier for the DPCS mode in L2: vanilla static or dynamic
BENCHMARK=$4		# String identifier for the SPEC CPU2006 benchmark to run
RUN_GROUP=$5		# String identifier for the run group to use.

GEM5_CONFIG_SUBSCRIPT=$PWD/subscripts/gem5-config-subscript-$CONFIG_ID.sh			# Full path to the gem5 config bash subscript

ROOT_OUTPUT_DIR=$PWD/m5out												# Full path to the root output directory for all simulations
CONFIG_OUTPUT_DIR=$ROOT_OUTPUT_DIR/$CONFIG_ID							# Full path to the output directory for this configuration

# Make sure necessary directories exist
mkdir $ROOT_OUTPUT_DIR
mkdir $CONFIG_OUTPUT_DIR

RUN_GROUP_OUTPUT_DIR=$CONFIG_OUTPUT_DIR/$RUN_GROUP					# Full path to the output directory for this configuration and run group
mkdir $RUN_GROUP_OUTPUT_DIR

BENCHMARK_OUTPUT_DIR=$RUN_GROUP_OUTPUT_DIR/$BENCHMARK
mkdir $BENCHMARK_OUTPUT_DIR

L1_FAULT_MAP_CSV=$PWD/dpcs-configs/faultmaps/faultmap-L1-$CONFIG_ID-$RUN_GROUP-*.csv
L2_FAULT_MAP_CSV=$PWD/dpcs-configs/faultmaps/faultmap-L2-$CONFIG_ID-$RUN_GROUP-*.csv
L1_RUNTIME_VDD_CSV=$PWD/dpcs-configs/parameters/runtime-vdds-L1-$CONFIG_ID-$RUN_GROUP-*.csv
L2_RUNTIME_VDD_CSV=$PWD/dpcs-configs/parameters/runtime-vdds-L2-$CONFIG_ID-$RUN_GROUP-*.csv
SIM_OUTPUT_DIR=$BENCHMARK_OUTPUT_DIR/$L1_MODE-$L2_MODE

mkdir $SIM_OUTPUT_DIR
./run_dpcs_gem5_alpha_benchmark.sh $BENCHMARK $L1_MODE $L2_MODE $GEM5_CONFIG_SUBSCRIPT $L1_FAULT_MAP_CSV $L2_FAULT_MAP_CSV $L1_RUNTIME_VDD_CSV $L2_RUNTIME_VDD_CSV $SIM_OUTPUT_DIR
