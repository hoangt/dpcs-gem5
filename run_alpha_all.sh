#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

# Get command line arguments
ARGC=$# # Get number of arguments excluding arg0 (the script itself)
if [[ "$ARGC" != 2 ]]; then # Bad number of arguments. Spit out help message.
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "USAGE: ./run_alpha_all.sh <CONFIG_ID> <RUN_NUMBER>"
	echo "NOTE: The following files must exist in the gem5 root directory, in addition to the gem5 installation therein:"
	echo "\tgem5params-L1-<CONFIG_ID>.csv"
	echo "\tgem5params-L2-<CONFIG_ID>.csv"
	echo ""
	echo "NOTE: The following file must exist in the current working directory:"
	echo "\trun_alpha_benchmark_<CONFIG_ID>.sh"
	echo ""
	echo "For example:"
	echo "\t./run_alpha_all.sh A 1"
	echo "\twould run gem5 configuration \"A\" and attach the run number of 1 to all output files."
	exit
fi

CONFIG_ID=$1 # String identifier for the system configuration, e.g. "foo" sans quotes
RUN_NUMBER=$2 # Run number string, e.g. "123" sans quotes

# Get the L1 and L2 cache configuration filenames
GEM5_L1_CONFIG_CSV=gem5params-L1-$CONFIG_ID.csv # Location of the L1 configuration CSV file
GEM5_L2_CONFIG_CSV=gem5params-L2-$CONFIG_ID.csv # Location of the L2 configuration CSV file

# Create the output file strings
BASELINE_STRING=baseline_$CONFIG_ID\_$RUN_NUMBER
STATIC_STRING=static_$CONFIG_ID\_$RUN_NUMBER
DYNAMIC_STRING=dynamic_$CONFIG_ID\_$RUN_NUMBER

# Configure UGE qsub options
#
# qsub options used:
# -V: export environment variables from this calling script to each job
# -N: name the job. I made these so that each job will be uniquely identified by its benchmark running as well as the output file string ID
# -l: resource allocation flags for maximum time requested as well as maximum memory requested.
# -M: cluster username(s) to email with updates on job status
# -m: mailing rules for job status.
#
################# FEEL FREE TO CHANGE THESE OPTIONS ###################
MAX_TIME_PER_RUN=5:00:00 # Maximum time of each script that will be invoked, HH:MM:SS. If this is exceeded, job will be killed.
MAX_MEM_PER_RUN=4096M # Maximum memory needed per script that will be invoked. If this is exceeded, job will be killed.
MAILING_LIST=mgottsch # List of users to email with status updates, separated by commas
#######################################################################

echo "Submitting dpcs-gem5 jobs..."

# Submit all the benchmarks!
BENCHMARKS="perlbench bzip2 gcc bwaves zeusmp gromacs leslie3d namd gobmk povray sjeng GemsFDTD h264ref lbm astar sphinx3"
i=1
for BENCHMARK in $BENCHMARKS; do
	echo "...$BENCHMARK (#$i)..."
	#qsub -V -N "dpcs-gem5-$BENCHMARK-$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh $BENCHMARK ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING
	#qsub -V -N "dpcs-gem5-$BENCHMARK-$STATIC_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh $BENCHMARK ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING
	#qsub -V -N "dpcs-gem5-$BENCHMARK-$DYNAMIC_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh $BENCHMARK ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING
	i=$((i+1))
done

echo "Done submitting dpcs-gem5 jobs."
echo "Use qstat to track job status and qdel to kill jobs. Job output can be found in your home directory."

# perlbench
#echo "...perlbench..."
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh perlbench ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$STATIC_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh perlbench ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$DYNAMIC_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh perlbench ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## bzip2
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh bzip2 ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh bzip2 ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh bzip2 ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## gcc
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gcc ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gcc ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gcc ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## bwaves
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh bwaves ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh bwaves ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh bwaves ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## zeusmp
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh zeusmp ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh zeusmp ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh zeusmp ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## gromacs
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gromacs ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gromacs ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gromacs ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## leslie3d
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh leslie3d ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh leslie3d ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh leslie3d ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## namd
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh namd ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh namd ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh namd ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING
#
## gobmk
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gobmk ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gobmk ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh gobmk ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING
#
## povray
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh povray ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh povray ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh povray ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING
#
## sjeng
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh sjeng ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh sjeng ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh sjeng ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING
#
## GemsFDTD
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh GemsFDTD ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh GemsFDTD ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh GemsFDTD ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING
#
## h264ref
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh h264ref ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh h264ref ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh h264ref ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## lbm
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh lbm ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh lbm ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh lbm ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## astar
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh astar ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh astar ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh astar ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
## sphinx3
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh sphinx3 ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh sphinx3 ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 
#
#qsub -V -N "dpcs-gem5_perlbench_$BASELINE_STRING" -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST -m ea ./run_alpha_benchmark_$CONFIG_ID.sh sphinx3 ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 
#
#echo "Done submitting dpcs-gem5 jobs!"
#
######################## OLD UCI CLUSTER CODE

#echo "Starting job submission..."
#
## bzip2 runset 1
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline1_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static1_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic1_A 
#
## bzip2 runset 2
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline2_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static2_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic2_A 
#
## bzip2 runset 3
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline3_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static3_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic3_A 
#
## bzip2 runset 4
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline4_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static4_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic4_A 
#
## bzip2 runset 5
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline5_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static5_A 
#
#qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic5_A 
#echo "Done submitting jobs!"


################ OLD NANOCAD-TESTBED CODE

#
#
#
#echo "Starting..."
#
#./run_alpha_benchmark_A.sh perlbench ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
#sleep 5
#./run_alpha_benchmark_A.sh perlbench ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
#sleep 5
#./run_alpha_benchmark_A.sh perlbench ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
#sleep 5
#
#./run_alpha_benchmark_A.sh bzip2 ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
#sleep 5
#./run_alpha_benchmark_A.sh bzip2 ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
#sleep 5
#./run_alpha_benchmark_A.sh bzip2 ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
#sleep 5
#
#./run_alpha_benchmark_A.sh gcc ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
#sleep 5
#./run_alpha_benchmark_A.sh gcc ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
#sleep 5
#
#wait
#
#./run_alpha_benchmark_A.sh gcc ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
#sleep 5
#
#./run_alpha_benchmark_A.sh bwaves ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
#sleep 5
#./run_alpha_benchmark_A.sh bwaves ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
#sleep 5
#./run_alpha_benchmark_A.sh bwaves ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
#sleep 5
#
#./run_alpha_benchmark_A.sh zeusmp ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
#sleep 5
#./run_alpha_benchmark_A.sh zeusmp ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
#sleep 5
#./run_alpha_benchmark_A.sh zeusmp ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
#sleep 5
#
#./run_alpha_benchmark_A.sh gromacs ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
#sleep 5
#
#wait
#
#./run_alpha_benchmark_A.sh gromacs ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
#sleep 5
#./run_alpha_benchmark_A.sh gromacs ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
#sleep 5
