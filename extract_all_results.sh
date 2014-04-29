#!/bin/bash
# Author: Mark Gottscho
# mgottscho@ucla.edu

# Check user input and help message
ARGC=$#
if [[ "$ARGC" != 1 ]]; then
	echo "Author: Mark Gottscho" >&2
	echo "mgottscho@ucla.edu" >&2
	echo "" >&2
	echo "USAGE: extract.sh <RUN_GROUP_OUTPUT_DIR>" >&2
	echo "Example: extract.sh m5out/foo-config/rungroup1" >&2
	exit
fi

# Change to user-specified directory
RUN_GROUP_OUTPUT_DIR=$1
cd $RUN_GROUP_OUTPUT_DIR

# Define column headers

# Benchmarks
COL_HEADERS="benchmark"
COL_HEADERS=" $COL_HEADERS baseline.static.dynamic"

# Overall stats
COL_HEADERS="sim_seconds"
COL_HEADERS=" $COL_HEADERS system.switch_cpus.numCycles"

# L1D stats
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.overall_accesses::total"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.overall_miss_rate::total"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.numFaultyBlocks_VDD1"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.numFaultyBlocks_VDD2"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.numFaultyBlocks_VDD3"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.accessEnergy_VDD1"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.accessEnergy_VDD2"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.accessEnergy_VDD3"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.accessEnergy_tot"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.transitionsTo_VDD1"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.transitionsTo_VDD2"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.transitionsTo_VDD3"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.proportionExecTime_VDD1"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.proportionExecTime_VDD2"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.proportionExecTime_VDD3"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.staticPower_avg"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.accessEnergy_tot"
COL_HEADERS=" $COL_HEADERS system.cpu.dcache.tags.staticPower_avg"

# L1I stats

# L2 stats
COL_HEADERS=" $COL_HEADERS system.l2.overall_accesses::total"
COL_HEADERS=" $COL_HEADERS system.l2.overall_miss_rate::total"
COL_HEADERS=" $COL_HEADERS system.l2.tags.numFaultyBlocks_VDD1"
COL_HEADERS=" $COL_HEADERS system.l2.tags.numFaultyBlocks_VDD2"
COL_HEADERS=" $COL_HEADERS system.l2.tags.numFaultyBlocks_VDD3"
COL_HEADERS=" $COL_HEADERS system.l2.tags.accessEnergy_VDD1"
COL_HEADERS=" $COL_HEADERS system.l2.tags.accessEnergy_VDD2"
COL_HEADERS=" $COL_HEADERS system.l2.tags.accessEnergy_VDD3"
COL_HEADERS=" $COL_HEADERS system.l2.tags.accessEnergy_tot"
COL_HEADERS=" $COL_HEADERS system.l2.tags.transitionsTo_VDD1"
COL_HEADERS=" $COL_HEADERS system.l2.tags.transitionsTo_VDD2"
COL_HEADERS=" $COL_HEADERS system.l2.tags.transitionsTo_VDD3"
COL_HEADERS=" $COL_HEADERS system.l2.tags.proportionExecTime_VDD1"
COL_HEADERS=" $COL_HEADERS system.l2.tags.proportionExecTime_VDD2"
COL_HEADERS=" $COL_HEADERS system.l2.tags.proportionExecTime_VDD3"
COL_HEADERS=" $COL_HEADERS system.l2.tags.staticPower_avg"
COL_HEADERS=" $COL_HEADERS system.l2.tags.accessEnergy_tot"
COL_HEADERS=" $COL_HEADERS system.l2.tags.staticPower_avg"

# Print column headers
for COL_HEADER in $COL_HEADERS; do
	echo -n $COL_HEADER
	echo -n ","
done
echo ""

# Define benchmarks
BENCHMARKS="perlbench bzip2 gcc bwaves zeusmp gromacs leslie3d namd gobmk povray sjeng GemsFDTD h264ref lbm astar sphinx3"
CACHE_CONFIGS="baseline static dynamic"

# Loop through benchmarks and print the relevant outputs on each row
for BENCHMARK in $BENCHMARKS; do
	echo -n $BENCHMARK # First column: Print benchmark name.
	echo -n ","

	# Loop through each cache configuration for this benchmark (unique simulation)
	for CACHE_CONFIG in $CACHE_CONFIGS; do
		echo -n $CACHE_CONFIG # Second column: Print the cache configuration
		echo -n ","

		# Loop through all column headers for this particular simulation
		for COL_HEADER in $COL_HEADERS; do 
			TMP=`grep $COL_HEADER $BENCHMARK/$CACHE_CONFIG/stats.txt | gawk '{print $2}'` # Get the relevant value for this column
			echo -n $TMP # Print the value
			echo -n "," # Comma delimit the columns
		done
		echo "" # End of line for this benchmark
	done
done
