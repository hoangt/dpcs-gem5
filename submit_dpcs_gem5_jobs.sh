#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

ARGC=$# # Get number of arguments excluding arg0 (the script itself). Check for help message condition.
if [[ "$ARGC" != 2 ]]; then # Bad number of arguments. 
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "USAGE: ./submit_dpcs_gem5_jobs.sh <CONFIG_ID> <RUN_GROUPS>"
	echo "NOTE: The following files must exist in the current working directory:"
	echo "	run_dpcs_gem5_alpha_benchmark.sh"
	echo "	gem5-config-subscript-<CONFIG_ID>.sh" 
	echo "	gem5params-L1-<CONFIG_ID>.csv"
	echo "	gem5params-L2-<CONFIG_ID>.csv"
	echo ""
	echo "For example:"
	echo "	./submit_dpcs_gem5_jobs.sh foo 5"
	echo "	would run gem5 configuration \"foo\" with 5 run groups."
	echo "	It would need the following files in the current working directory:"
	echo "		run_dpcs_gem5_alpha_benchmark.sh"
	echo "		gem5-config-subscript-foo.sh"
	echo "		gem5params-L1-foo.csv"
	echo "		gem5params-L2-foo.csv"
	exit
fi

# Get the arguments.
CONFIG_ID=$1		# String identifier for the system configuration, e.g. "foo" sans quotes
RUN_GROUPS=$2		# Run groups, e.g. 5

########################## FEEL FREE TO CHANGE THESE OPTIONS ##################################
BENCHMARKS="perlbench bzip2 gcc bwaves zeusmp gromacs leslie3d namd gobmk povray sjeng GemsFDTD h264ref lbm astar sphinx3"		# String of SPEC CPU2006 benchmark names to run, delimited by spaces.
GEM5_CONFIG_SUBSCRIPT=$PWD/gem5-config-subscript-$CONFIG_ID.sh			# Full path to the gem5 config bash subscript
GEM5_L1_CONFIG=$PWD/gem5params-L1-$CONFIG_ID.csv 						# Full path to the L1 cache configuration CSV
GEM5_L2_CONFIG=$PWD/gem5params-L2-$CONFIG_ID.csv 						# Full path to the L2 cache configuration CSV

ROOT_OUTPUT_DIR=$PWD/m5out												# Full path to the root output directory for all simulations
CONFIG_OUTPUT_DIR=$ROOT_OUTPUT_DIR/$CONFIG_ID							# Full path to the output directory for this configuration

# qsub options used:
# -V: export environment variables from this calling script to each job
# -N: name the job. I made these so that each job will be uniquely identified by its benchmark running as well as the output file string ID
# -l: resource allocation flags for maximum time requested as well as maximum memory requested.
# -M: cluster username(s) to email with updates on job status
# -m: mailing rules for job status.
MAX_TIME_PER_RUN=08:00:00 	# Maximum time of each script that will be invoked, HH:MM:SS. If this is exceeded, job will be killed.
MAX_MEM_PER_RUN=3072M 		# Maximum memory needed per script that will be invoked. If this is exceeded, job will be killed.
MAILING_LIST=mgottsch 		# List of users to email with status updates, separated by commas
###############################################################################################

# Make sure necessary directories exist
mkdir $ROOT_OUTPUT_DIR
mkdir $CONFIG_OUTPUT_DIR

for (( RUN_GROUP=1; RUN_GROUP<=$RUN_GROUPS; RUN_GROUP++ )); do
	RUN_GROUP_OUTPUT_DIR=$CONFIG_OUTPUT_DIR/$RUN_GROUP					# Full path to the output directory for this configuration and run group
	mkdir $RUN_GROUP_OUTPUT_DIR

	# Submit all the benchmarks!
	echo "Submitting dpcs-gem5 jobs for run group $RUN_GROUP..."
	echo ""
	for BENCHMARK in $BENCHMARKS; do
		echo "$BENCHMARK..."
		BENCHMARK_OUTPUT_DIR=$RUN_GROUP_OUTPUT_DIR/$BENCHMARK
		mkdir $BENCHMARK_OUTPUT_DIR

		JOB_NAME="dpcs-gem5-$CONFIG_ID-$RUN_GROUP-$BENCHMARK-baseline"
		SIM_OUTPUT_DIR=$BENCHMARK_OUTPUT_DIR/baseline
		mkdir $SIM_OUTPUT_DIR
		qsub -V -N $JOB_NAME -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m bea ./run_dpcs_gem5_alpha_benchmark.sh $BENCHMARK vanilla vanilla $GEM5_CONFIG_SUBSCRIPT $GEM5_L1_CONFIG $GEM5_L2_CONFIG no $SIM_OUTPUT_DIR

		JOB_NAME="dpcs-gem5-$CONFIG_ID-$RUN_GROUP-$BENCHMARK-static"
		SIM_OUTPUT_DIR=$BENCHMARK_OUTPUT_DIR/static
		mkdir $SIM_OUTPUT_DIR
		qsub -V -N $JOB_NAME -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m bea ./run_dpcs_gem5_alpha_benchmark.sh $BENCHMARK static static $GEM5_CONFIG_SUBSCRIPT $GEM5_L1_CONFIG $GEM5_L2_CONFIG no $SIM_OUTPUT_DIR
		
		JOB_NAME="dpcs-gem5-$CONFIG_ID-$RUN_GROUP-$BENCHMARK-dynamic"
		SIM_OUTPUT_DIR=$BENCHMARK_OUTPUT_DIR/dynamic
		mkdir $SIM_OUTPUT_DIR
		qsub -V -N $JOB_NAME -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m bea ./run_dpcs_gem5_alpha_benchmark.sh $BENCHMARK dynamic dynamic $GEM5_CONFIG_SUBSCRIPT $GEM5_L1_CONFIG $GEM5_L2_CONFIG no $SIM_OUTPUT_DIR
	done

done

echo "Done submitting dpcs-gem5 jobs."
echo "Use qstat to track job status and qdel to kill jobs. Job output can be found in your home directory."
