#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

ARGC=$# # Get number of arguments excluding arg0 (the script itself). Check for help message condition.
if [[ "$ARGC" != 9 ]]; then # Bad number of arguments. 
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "This script runs a single gem5 simulation of a single SPEC CPU2006 benchmark for Alpha ISA."
	echo ""
	echo "USAGE: run_dpcs_gem5_alpha_benchmark.sh <BENCHMARK> <INPUT_SIZE> <L1_CACHE_MODE> <L2_CACHE_MODE> <GEM5_CONFIG> <GEM5_L1_CONFIG> <GEM5_L2_CONFIG> <MC> <RUN_ID>"
	echo "EXAMPLE: ./run_dpcs_gem5_alpha_benchmark.sh bzip2 ref vanilla vanilla gem5-config-foo.txt gem5params-L1-foo.csv gem5params-L2-foo.csv no baseline_foo_1"
	echo "NOTE: Monte Carlo feature is not yet implemented, just say no!"
	echo ""
	echo "A single --help help or -h argument will bring this message back."
	exit
fi

# Get command line input
BENCHMARK=$1					# Benchmark name, e.g. bzip2
INPUT_SIZE=$2					# test or ref data sets. NOTE: Right now INPUT_SIZE does not actually get passed to gem5 script!
L1_CACHE_MODE=$3				# vanilla/static/dynamic cache -- L1
L2_CACHE_MODE=$4				# vanilla/static/dynamic cache -- L2
GEM5_CONFIG=$5					# full path to the gem5 configuration file
GEM5_L1_CONFIG=$6				# full path to the L1 cache configuration file
GEM5_L2_CONFIG=$7				# full path to the L2 cache configuration file
MC=$8							# yes/no for monte carlo voltage finding. CURRENTLY NOT YET IMPLEMENTED. JUST SAY "no"
RUN_ID=$9						# run ID for file tracking purposes, e.g. "baseline1"

# Check inp
if [[ "$INPUT_SIZE" != "test" && "$INPUT_SIZE" != "ref" ]]; then
	echo 'INPUT_SIZE needs to be either test or ref! Exiting.'
	exit 1
fi

################## DIRECTORY VARIABLES: MODIFY ACCORDINGLY #######
GEM5_DIR=/u/home/puneet/mgottsch/dpcs-gem5					# Install location of gem5
SPEC_DIR=/u/home/puneet/mgottsch/spec_cpu2006_install		# Install location of your SPEC2006 benchmarks
GEM5_OUT_ROOT_DIR=$GEM5_DIR/m5out							# Default gem5 output directory, e.g. statistics
##################################################################


######################### BENCHMARK CODENAMES ####################
PERLBENCH_CODE=400.perlbench
BZIP2_CODE=401.bzip2
GCC_CODE=403.gcc
BWAVES_CODE=410.bwaves
GAMESS_CODE=416.gamess
MCF_CODE=429.mcf
MILC_CODE=433.milc
ZEUSMP_CODE=434.zeusmp
GROMACS_CODE=435.gromacs
CACTUSADM_CODE=436.cactusADM
LESLIE3D_CODE=437.leslie3d
NAMD_CODE=444.namd
GOBMK_CODE=445.gobmk
DEALII_CODE=447.dealII
SOPLEX_CODE=450.soplex
POVRAY_CODE=453.povray
CALCULIX_CODE=454.calculix
HMMER_CODE=456.hmmer
SJENG_CODE=458.sjeng
GEMSFDTD_CODE=459.GemsFDTD
LIBQUANTUM_CODE=462.libquantum
H264REF_CODE=464.h264ref
TONTO_CODE=465.tonto
LBM_CODE=470.lbm
OMNETPP_CODE=471.omnetpp
ASTAR_CODE=473.astar
WRF_CODE=481.wrf
SPHINX3_CODE=482.sphinx3
XALANCBMK_CODE=483.xalancbmk
SPECRAND_INT_CODE=998.specrand
SPECRAND_FLOAT_CODE=999.specrand
##################################################################

#################### BENCHMARK CODE MAPPING ######################
BENCHMARK_CODE="none"

if [[ "$BENCHMARK" == "perlbench" ]]; then
	BENCHMARK_CODE=$PERLBENCH_CODE
fi
if [[ "$BENCHMARK" == "bzip2" ]]; then
	BENCHMARK_CODE=$BZIP2_CODE
fi
if [[ "$BENCHMARK" == "gcc" ]]; then
	BENCHMARK_CODE=$GCC_CODE
fi
if [[ "$BENCHMARK" == "bwaves" ]]; then
	BENCHMARK_CODE=$BWAVES_CODE
fi
if [[ "$BENCHMARK" == "gamess" ]]; then
	BENCHMARK_CODE=$GAMESS_CODE
fi
if [[ "$BENCHMARK" == "mcf" ]]; then
	BENCHMARK_CODE=$MCF_CODE
fi
if [[ "$BENCHMARK" == "milc" ]]; then
	BENCHMARK_CODE=$MILC_CODE
fi
if [[ "$BENCHMARK" == "zeusmp" ]]; then
	BENCHMARK_CODE=$ZEUSMP_CODE
fi
if [[ "$BENCHMARK" == "gromacs" ]]; then
	BENCHMARK_CODE=$GROMACS_CODE
fi
if [[ "$BENCHMARK" == "cactusADM" ]]; then
	BENCHMARK_CODE=$CACTUSADM_CODE
fi
if [[ "$BENCHMARK" == "leslie3d" ]]; then
	BENCHMARK_CODE=$LESLIE3D_CODE
fi
if [[ "$BENCHMARK" == "namd" ]]; then
	BENCHMARK_CODE=$NAMD_CODE
fi
if [[ "$BENCHMARK" == "gobmk" ]]; then
	BENCHMARK_CODE=$GOBMK_CODE
fi
if [[ "$BENCHMARK" == "dealII" ]]; then # DOES NOT WORK
	BENCHMARK_CODE=$DEALII_CODE
fi
if [[ "$BENCHMARK" == "soplex" ]]; then
	BENCHMARK_CODE=$SOPLEX_CODE
fi
if [[ "$BENCHMARK" == "povray" ]]; then
	BENCHMARK_CODE=$POVRAY_CODE
fi
if [[ "$BENCHMARK" == "calculix" ]]; then
	BENCHMARK_CODE=$CALCULIX_CODE
fi
if [[ "$BENCHMARK" == "hmmer" ]]; then
	BENCHMARK_CODE=$HMMER_CODE
fi
if [[ "$BENCHMARK" == "sjeng" ]]; then
	BENCHMARK_CODE=$SJENG_CODE
fi
if [[ "$BENCHMARK" == "GemsFDTD" ]]; then
	BENCHMARK_CODE=$GEMSFDTD_CODE
fi
if [[ "$BENCHMARK" == "libquantum" ]]; then
	BENCHMARK_CODE=$LIBQUANTUM_CODE
fi
if [[ "$BENCHMARK" == "h264ref" ]]; then
	BENCHMARK_CODE=$H264REF_CODE
fi
if [[ "$BENCHMARK" == "tonto" ]]; then
	BENCHMARK_CODE=$TONTO_CODE
fi
if [[ "$BENCHMARK" == "lbm" ]]; then
	BENCHMARK_CODE=$LBM_CODE
fi
if [[ "$BENCHMARK" == "omnetpp" ]]; then
	BENCHMARK_CODE=$OMNETPP_CODE
fi
if [[ "$BENCHMARK" == "astar" ]]; then
	BENCHMARK_CODE=$ASTAR_CODE
fi
if [[ "$BENCHMARK" == "wrf" ]]; then
	BENCHMARK_CODE=$WRF_CODE
fi
if [[ "$BENCHMARK" == "sphinx3" ]]; then
	BENCHMARK_CODE=$SPHINX3_CODE
fi
if [[ "$BENCHMARK" == "xalancbmk" ]]; then # DOES NOT WORK
	BENCHMARK_CODE=$XALANCBMK_CODE
fi
if [[ "$BENCHMARK" == "specrand_i" ]]; then
	BENCHMARK_CODE=$SPECRAND_INT_CODE
fi
if [[ "$BENCHMARK" == "specrand_f" ]]; then
	BENCHMARK_CODE=$SPECRAND_FLOAT_CODE
fi

# Sanity check
if [[ "$BENCHMARK_CODE" == "none" ]]; then
	echo "Input benchmark selection did not match any, exiting!"
	exit 1
fi
##################################################################


##################### DIRECTORY PATHS ############################
# Derive some directory paths for various things
BENCH_DIR=$SPEC_DIR/benchspec/CPU2006								# Directory where the benchmarks are kept in SPEC installation
BENCHMARK_DIR=$BENCH_DIR/$BENCHMARK_CODE							# Directory for particular selected benchmark
RUN_DIR=$BENCHMARK_DIR/run/run_base_$INPUT_SIZE\_alpha.0000			# Directory for particular selected benchmark runtime
RUN_OUT_DIR=$GEM5_OUT_ROOT_DIR/$RUN_ID								# Directory for particular run ID outputs
BENCH_OUT_DIR=$RUN_OUT_DIR/$BENCHMARK								# Directory for particular selected benchmark outputs inside this run ID

# Make sure that the relevant output directories pre-exist so that tee has no issue with them.
# If they already exist, then mkdir is harmless.
mkdir $GEM5_OUT_ROOT_DIR
mkdir $RUN_OUT_DIR
mkdir $BENCH_OUT_DIR
##################################################################


############## REPORTING CONFIGURATION ###########################
SCRIPT_OUT=$BENCH_OUT_DIR/runscript.log								# File log for this script's stdout henceforth

echo "==========================================================" | tee $SCRIPT_OUT
echo "--> BENCHMARK:"								$BENCHMARK | tee $SCRIPT_OUT
echo "--> INPUT_SIZE:"								$INPUT_SIZE | tee $SCRIPT_OUT
echo "--> L1_CACHE_MODE:"							$L1_CACHE_MODE | tee $SCRIPT_OUT
echo "--> L2_CACHE_MODE:"							$L2_CACHE_MODE | tee $SCRIPT_OUT
echo "--> GEM5_CONFIG:"								$GEM5_CONFIG | tee $SCRIPT_OUT
echo "--> GEM5_L1_CONFIG:"							$GEM5_L1_CONFIG | tee $SCRIPT_OUT
echo "--> GEM5_L2_CONFIG:"							$GEM5_L2_CONFIG | tee $SCRIPT_OUT
echo "--> MONTE CARLO:"								$MC | tee $SCRIPT_OUT
echo "--> RUN_ID:"									$RUN_ID | tee $SCRIPT_OUT
echo "BENCHMARK_CODE:"								$BENCHMARK_CODE | tee $SCRIPT_OUT
echo "----------------------------------------------------------" | tee $SCRIPT_OUT
echo "SPEC_DIR:"									$SPEC_DIR | tee $SCRIPT_OUT
echo "BENCH_DIR:"									$BENCH_DIR | tee $SCRIPT_OUT
echo "BENCHMARK_DIR:"								$BENCHMARK_DIR | tee $SCRIPT_OUT
echo "RUN_DIR:"										$RUN_DIR | tee $SCRIPT_OUT
echo "----------------------------------------------------------" | tee $SCRIPT_OUT
echo "GEM5_OUT_ROOT_DIR:"							$GEM5_OUT_ROOT_DIR | tee $SCRIPT_OUT
echo "RUN_OUT_DIR:"									$RUN_OUT_DIR | tee $SCRIPT_OUT
echo "BENCH_OUT_DIR:"								$BENCH_OUT_DIR | tee $SCRIPT_OUT
echo "SCRIPT_OUT:"									$SCRIPT_OUT | tee $SCRIPT_OUT
echo "==========================================================" | tee $SCRIPT_OUT
##################################################################


#################### LAUNCH GEM5 SIMULATION ######################
echo ""
echo "Changing to runtime directory:	$RUN_DIR" | tee $SCRIPT_OUT
cd $RUN_DIR

# Read in and execute commands from GEM5_CONFIG file that corresponds to the gem5 call itself.
# I know this isn't safe. Just play nice with my script, please. =)
GEM5_RUN_CMD=$(cat $GEM5_CONFIG)
GEM5_RUN_CMD=$(echo -e $GEM5_RUN_CMD) # Remove backslashes
echo "Running the following gem5 command:" | tee $SCRIPT_OUT
echo "" | tee $SCRIPT_OUT
echo $GEM5_RUN_CMD | tee $SCRIPT_OUT
echo "--------- Here goes nothing! Starting gem5! ------------" | tee $SCRIPT_OUT
echo "" | tee $SCRIPT_OUT
echo "" | tee $SCRIPT_OUT
eval $GEM5_RUN_CMD
