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
STAT_FIELDS=" $STAT_FIELDS system.switch_cpus.ipc_total"

# L1D stats
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_accesses::total"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.hit_latency"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_miss_rate::total"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_avg_miss_latency::switch_cpus.inst"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_avg_miss_latency::switch_cpus.data"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_avg_miss_latency::total"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_avg_access_time::switch_cpus.inst"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.overall_avg_access_time::switch_cpus.data"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.total_dpcs_transition_cycles"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.occ_percent::total"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.accessPower_avg"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticEnergy_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticEnergy_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticEnergy_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.staticPower_avg"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.cycles_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.cycles_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.cycles_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.proportionExecTime_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.proportionExecTime_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.proportionExecTime_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.avgConsecutiveCycles_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.avgConsecutiveCycles_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.avgConsecutiveCycles_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.transitionsTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.transitionsTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.transitionsTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numUnchangedNotFaultyTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numUnchangedNotFaultyTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numUnchangedNotFaultyTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numInvalidateOnlyTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numInvalidateOnlyTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numInvalidateOnlyTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numNoConsequenceTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numNoConsequenceTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numNoConsequenceTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyWriteBacksTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyWriteBacksTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyWriteBacksTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numMadeAvailableTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numMadeAvailableTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numMadeAvailableTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.faultyWriteBackRateTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.faultyWriteBackRateTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.faultyWriteBackRateTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacementsInFaultySets_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacementsInFaultySets_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacementsInFaultySets_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacements_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacements_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacements_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacementsInFaultySetsRate_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacementsInFaultySetsRate_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockReplacementsInFaultySetsRate_VDD3"
# These are basically just echoed input parameters, spit out in the simulation so we can see everything nicely in one table
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.dpcs_mode"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.dpcs_threshold_high"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.dpcs_threshold_low"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.dpcs_sample_interval"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.dpcs_vdd_switch_overhead"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.voltage_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.voltage_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.voltage_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.static_power_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.static_power_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.static_power_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.energy_per_access_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.energy_per_access_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.energy_per_access_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyBlocks_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyBlocks_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.numFaultyBlocks_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockFaultRate_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockFaultRate_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.cpu.dcache.tags.blockFaultRate_VDD3"

# L1I stats

# L2 stats
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_accesses::total"
STAT_FIELDS=" $STAT_FIELDS system.l2.hit_latency"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_miss_rate::total"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_avg_miss_latency::switch_cpus.inst"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_avg_miss_latency::switch_cpus.data"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_avg_miss_latency::total"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_avg_access_time::switch_cpus.inst"
STAT_FIELDS=" $STAT_FIELDS system.l2.overall_avg_access_time::switch_cpus.data"
STAT_FIELDS=" $STAT_FIELDS system.l2.total_dpcs_transition_cycles"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.occ_percent::total"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.accessPower_avg"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticEnergy_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticEnergy_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticEnergy_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticEnergy_tot"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.staticPower_avg"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.cycles_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.cycles_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.cycles_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.proportionExecTime_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.proportionExecTime_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.proportionExecTime_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.avgConsecutiveCycles_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.avgConsecutiveCycles_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.avgConsecutiveCycles_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.transitionsTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.transitionsTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.transitionsTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numUnchangedNotFaultyTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numUnchangedNotFaultyTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numUnchangedNotFaultyTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numInvalidateOnlyTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numInvalidateOnlyTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numInvalidateOnlyTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numNoConsequenceTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numNoConsequenceTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numNoConsequenceTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyWriteBacksTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyWriteBacksTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyWriteBacksTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numMadeAvailableTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numMadeAvailableTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numMadeAvailableTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.faultyWriteBackRateTo_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.faultyWriteBackRateTo_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.faultyWriteBackRateTo_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacementsInFaultySets_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacementsInFaultySets_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacementsInFaultySets_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacements_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacements_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacements_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacementsInFaultySetsRate_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacementsInFaultySetsRate_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockReplacementsInFaultySetsRate_VDD3"
# These are basically just echoed input parameters, spit out in the simulation so we can see everything nicely in one table
STAT_FIELDS=" $STAT_FIELDS system.l2.dpcs_mode"
STAT_FIELDS=" $STAT_FIELDS system.l2.dpcs_threshold_high"
STAT_FIELDS=" $STAT_FIELDS system.l2.dpcs_threshold_low"
STAT_FIELDS=" $STAT_FIELDS system.l2.dpcs_sample_interval"
STAT_FIELDS=" $STAT_FIELDS system.l2.dpcs_vdd_switch_overhead"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.voltage_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.voltage_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.voltage_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.static_power_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.static_power_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.static_power_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.energy_per_access_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.energy_per_access_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.energy_per_access_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyBlocks_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyBlocks_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.numFaultyBlocks_VDD3"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockFaultRate_VDD1"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockFaultRate_VDD2"
STAT_FIELDS=" $STAT_FIELDS system.l2.tags.blockFaultRate_VDD3"

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
	
	#CACHE_CONFIG_ITER=0
	# Loop through each cache configuration for this benchmark
	for CACHE_CONFIG in $CACHE_CONFIGS; do
		#if [[ $CACHE_CONFIG_ITER > 0 ]]; then
		#	echo -n "," # Print indent
		#fi

	#	RUN_GROUP_ITER=0
		# Loop through each run group for this cache config+benchmark+config
		for RUN_GROUP in $RUN_GROUPS; do
			#if [[ $RUN_GROUP_ITER > 0 ]]; then
			#	echo -n "," # Print indent
			#	echo -n "," # Print indent
			#fi

			echo -n $BENCHMARK # First column: Print benchmark name.
			echo -n ","
		
			echo -n $CACHE_CONFIG # Second column: Print the cache configuration
			echo -n ","

			echo -n $RUN_GROUP # Third column: Print the run group
			echo -n ","

			# Loop through all column headers for this particular simulation
			for STAT_FIELD in $STAT_FIELDS; do 
				if [[ !(-d "$RUN_GROUP/$BENCHMARK/$CACHE_CONFIG") ]]; then # Dir doesn't exist. This is to handle bugs or baseline runs, which only go once since no need to repetitively do them
					echo -n "," # Empty cell
				else	 # Common case
					TMP=`grep $STAT_FIELD $RUN_GROUP/$BENCHMARK/$CACHE_CONFIG/stats.txt | gawk '{print $2}'` # Get the relevant value for this column
				
					echo -n $TMP # Print the value
					echo -n "," # Comma delimit the columns
				fi
			done

			echo "" # End of line for this particular simulation
			#RUN_GROUP_ITER=$(($RUN_GROUP_ITER + 1))
		done
		#CACHE_CONFIG_ITER=$(($CACHE_CONFIG_ITER + 1))
	done
done
