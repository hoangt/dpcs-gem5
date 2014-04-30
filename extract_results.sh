#!/bin/bash
# Author: Mark Gottscho
# mgottscho@ucla.edu

# Check user input and help message
ARGC=$#
if [[ "$ARGC" != 2 ]]; then
	echo "Author: Mark Gottscho" >&2
	echo "mgottscho@ucla.edu" >&2
	echo "" >&2
	echo "USAGE: extract_results.sh <CONFIG_DIR> <RUN_GROUPS>" >&2
	echo "Example: extract_results.sh m5out/foo-config \"grp1 grp2 grp3 grp4 grp5\"" >&2
	echo "NOTE: The run groups should have exactly matching directory names." >&2
	exit
fi

# Get user inputs
CONFIG_OUTPUT_DIR=$1
RUN_GROUPS=$2
cd $CONFIG_OUTPUT_DIR

# Define stat fields of interest to extract in a giant space-delimited string

# Overall stats
STAT_FIELDS="sim_seconds"
STAT_FIELDS=" $STAT_FIELDS system.switch_cpus.numCycles"

# L1D stats
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_accesses::total"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_miss_rate::total"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyBlocks_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyBlocks_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyBlocks_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.transitionsTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.transitionsTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.transitionsTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.proportionExecTime_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.proportionExecTime_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.proportionExecTime_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticPower_avg"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticPower_avg"

# L1I stats

# L2 stats
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_accesses::total"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_miss_rate::total"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyBlocks_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyBlocks_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyBlocks_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.transitionsTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.transitionsTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.transitionsTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.proportionExecTime_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.proportionExecTime_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.proportionExecTime_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticPower_avg"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticPower_avg"

# Define column headers
COL_HEADERS="benchmark"
COL_HEADERS=" $COL_HEADERS baseline.static.dynamic"
COL_HEADERS=" $COL_HEADERS rungroup"
COL_HEADERS=" $COL_HEADERS $STAT_FIELDS" # Add in the stat fields

# Print column headers
for COL_HEADER in $COL_HEADERS; do
	echo -n $COL_HEADER
	echo -n ","
done
echo ""

# Define benchmarks
BENCHMARKS="perlbench bzip2 gcc bwaves zeusmp gromacs leslie3d namd gobmk povray sjeng GemsFDTD h264ref lbm astar sphinx3"
CACHE_CONFIGS="baseline static dynamic"

# Loop through each benchmark
for BENCHMARK in $BENCHMARKS; do
	echo -n $BENCHMARK # First column: Print benchmark name.
	echo -n ","

	CACHE_CONFIG_ITER=0
	# Loop through each cache configuration for this benchmark
	for CACHE_CONFIG in $CACHE_CONFIGS; do
		if [[ $CACHE_CONFIG_ITER > 0 ]]; then
			echo -n "," # Print indent
		fi

		echo -n $CACHE_CONFIG # Second column: Print the cache configuration
		echo -n ","
	
		RUN_GROUP_ITER=0
		# Loop through each run group for this cache config+benchmark+config
		for RUN_GROUP in $RUN_GROUPS; do
			if [[ $RUN_GROUP_ITER > 0 ]]; then
				echo -n "," # Print indent
				echo -n "," # Print indent
			fi

			echo -n $RUN_GROUP # Third column: Print the run group
			echo -n ","

			# Loop through all column headers for this particular simulation
			for STAT_FIELD in $STAT_FIELDS; do 
				TMP=`grep $STAT_FIELD $RUN_GROUP/$BENCHMARK/$CACHE_CONFIG/stats.txt | gawk '{print $2}'` # Get the relevant value for this column
				
				echo -n $TMP # Print the value
				echo -n "," # Comma delimit the columns
			done

			echo "" # End of line for this particular simulation
			RUN_GROUP_ITER=$(($RUN_GROUP_ITER + 1))
		done
		CACHE_CONFIG_ITER=$(($CACHE_CONFIG_ITER + 1))
	done
done
