#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

# Get the arguments.
CONFIG_ID=$1		# String identifier for the system configuration, e.g. "foo" sans quotes
RUN_GROUP=1

BENCHMARK="perlbench"		# String of SPEC CPU2006 benchmark names to run, delimited by spaces.
GEM5_CONFIG_SUBSCRIPT=$PWD/subscripts/gem5-config-subscript-$CONFIG_ID.sh			# Full path to the gem5 config bash subscript
GEM5_L1_CONFIG=$PWD/parameters/gem5params-L1-$CONFIG_ID.csv 						# Full path to the L1 cache configuration CSV
GEM5_L2_CONFIG=$PWD/parameters/gem5params-L2-$CONFIG_ID.csv 						# Full path to the L2 cache configuration CSV

ROOT_OUTPUT_DIR=$PWD/m5out												# Full path to the root output directory for all simulations
CONFIG_OUTPUT_DIR=$ROOT_OUTPUT_DIR/$CONFIG_ID							# Full path to the output directory for this configuration

# Make sure necessary directories exist
mkdir $ROOT_OUTPUT_DIR
mkdir $CONFIG_OUTPUT_DIR

RUN_GROUP_OUTPUT_DIR=$CONFIG_OUTPUT_DIR/$RUN_GROUP					# Full path to the output directory for this configuration and run group
mkdir $RUN_GROUP_OUTPUT_DIR

BENCHMARK_OUTPUT_DIR=$RUN_GROUP_OUTPUT_DIR/$BENCHMARK
mkdir $BENCHMARK_OUTPUT_DIR

L1_FAULT_MAP_CSV=$PWD/faultmaps/faultmap-L1-$CONFIG_ID-$RUN_GROUP-*.csv
L2_FAULT_MAP_CSV=$PWD/faultmaps/faultmap-L2-$CONFIG_ID-$RUN_GROUP-*.csv
L1_RUNTIME_VDD_CSV=$PWD/faultmaps/runtime-vdds-L1-$CONFIG_ID-$RUN_GROUP-*.csv
L2_RUNTIME_VDD_CSV=$PWD/faultmaps/runtime-vdds-L2-$CONFIG_ID-$RUN_GROUP-*.csv
SIM_OUTPUT_DIR=$BENCHMARK_OUTPUT_DIR/baseline

mkdir $SIM_OUTPUT_DIR
./run_dpcs_gem5_alpha_benchmark.sh $BENCHMARK vanilla vanilla $GEM5_CONFIG_SUBSCRIPT $GEM5_L1_CONFIG $GEM5_L2_CONFIG $L1_FAULT_MAP_CSV $L2_FAULT_MAP_CSV $L1_RUNTIME_VDD_CSV $L2_RUNTIME_VDD_CSV $SIM_OUTPUT_DIR
