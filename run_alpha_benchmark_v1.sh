#!/bin/bash

# Author: Mark Gottscho
# Usage: run_alpha_benchmark.sh <SPEC2006 BENCHMARK> <DATA_SIZE> <L1_CACHE_MODE> <L2_CACHE_MODE> <RUNID>
# Example: ./run_alpha_benchmark.sh bzip2 ref vanilla dpcs testrun

################## DIRECTORY VARIABLES: MODIFY ACCORDINGLY #######
GEM5_DIR=/home/mark/gem5							# Install location of gem5
SPEC_DIR=/home/mark/spec_cpu2006_install		# Install location of your SPEC2006 benchmarks
GEM5_OUT_ROOT_DIR=$GEM5_DIR/m5out				# Default gem5 output directory, e.g. statistics
##################################################################

################## BENCHMARK CODENAMES: DON'T MODIFY #############
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

#################### BENCHMARK CODE MAPPING: DON'T MODIFY ########
BENCHMARK=$1											# User input for benchmark name, e.g. bzip2
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
	echo 'User-specified benchmark did not match any, exiting!'
	exit 1
fi

INPUT_SIZE=$2			# user input for test or ref data sets

### NOTE: Right now INPUT_SIZE does not actually get passed to gem5 script!

L1_CACHE_MODE=$3			# user input for regular/vanilla/baseline cache or DPCS mod -- L1
L2_CACHE_MODE=$4			# user input for regular/vanilla/baseline cache or DPCS mod -- L2
RUN_ID=$5												# User input for run ID for file tracking purposes, e.g. "baseline1"

if [[ "$INPUT_SIZE" != "test" && "$INPUT_SIZE" != "ref" ]]; then
	echo 'Arg3 input size needs to be either test or ref! Exiting.'
	exit 1
fi
	
BENCH_DIR=$SPEC_DIR/benchspec/CPU2006			# Where the benchmarks are kept in SPEC installation
BENCHMARK_DIR=$BENCH_DIR/$BENCHMARK_CODE
RUN_DIR=$BENCHMARK_DIR/run/run_base_$(echo $INPUT_SIZE)_alpha.0000
BENCH_OUT_DIR=$GEM5_OUT_ROOT_DIR/$BENCHMARK
RUN_OUT_DIR=$BENCH_OUT_DIR/$RUN_ID
SCRIPT_OUT=$RUN_OUT_DIR/runscript.log

# Make sure that the directories pre-exist so that tee has no issue with them
mkdir $BENCH_OUT_DIR
mkdir $RUN_OUT_DIR
##################################################################


###################### REPORTING TO CONSOLE ######################
echo "==========================================================" | tee $SCRIPT_OUT
echo "--> BENCHMARK:"								$BENCHMARK | tee $SCRIPT_OUT
echo "--> INPUT_SIZE:"								$INPUT_SIZE | tee $SCRIPT_OUT
echo "--> L1_CACHE_MODE:"							$L1_CACHE_MODE | tee $SCRIPT_OUT
echo "--> L2_CACHE_MODE:"							$L2_CACHE_MODE | tee $SCRIPT_OUT
echo "--> RUN_ID:"									$RUN_ID | tee $SCRIPT_OUT
echo "BENCHMARK_CODE:"								$BENCHMARK_CODE | tee $SCRIPT_OUT
echo "----------------------------------------------------------" | tee $SCRIPT_OUT
echo "SPEC_DIR:"									$SPEC_DIR | tee $SCRIPT_OUT
echo "BENCH_DIR:"									$BENCH_DIR | tee $SCRIPT_OUT
echo "BENCHMARK_DIR:"								$BENCHMARK_DIR | tee $SCRIPT_OUT
echo "RUN_DIR:"										$RUN_DIR | tee $SCRIPT_OUT
echo "----------------------------------------------------------" | tee $SCRIPT_OUT
echo "GEM5_OUT_ROOT_DIR:"							$GEM5_OUT_ROOT_DIR | tee $SCRIPT_OUT
echo "BENCH_OUT_DIR:"								$BENCH_OUT_DIR | tee $SCRIPT_OUT
echo "RUN_OUT_DIR:"									$RUN_OUT_DIR | tee $SCRIPT_OUT
echo "SCRIPT_OUT:"									$SCRIPT_OUT | tee $SCRIPT_OUT
echo "==========================================================" | tee $SCRIPT_OUT

echo "Changing to directory:	$RUN_DIR" | tee $SCRIPT_OUT
cd $RUN_DIR
echo -e "Starting gem5......\n\n\n" | tee $SCRIPT_OUT
##################################################################


################# LAUNCH GEM5: MODIFY ACCORDINGLY ################
$GEM5_DIR/build/ALPHA/gem5.fast \
	--outdir=$RUN_OUT_DIR \
	$GEM5_DIR/configs/example/spec06_config.py \
	--cpu-type=detailed \
	--num-cpus=1 \
	--sys-clock="2GHz" \
	--sys-voltage="1V" \
	--cpu-clock="2GHz" \
	--mem-type=ddr3_1600_x64 \
	--mem-channels=1 \
	--mem-size="2048MB" \
	--caches \
	--l2cache \
	--num-l2caches=1 \
	--num-l3caches=0 \
	--l1d_size="64kB" \
	--l1i_size="64kB" \
	--l2_size="2MB" \
	--l1d_assoc=4 \
	--l1i_assoc=4 \
	--l2_assoc=8 \
	--cacheline_size="64" \
	--fast-forward=1000000000 \
	--maxinsts=2000000000 \
	--at-instruction \
	--benchmark=$BENCHMARK \
	--benchmark_stdout=$RUN_OUT_DIR/$BENCHMARK.out \
	--benchmark_stderr=$RUN_OUT_DIR/$BENCHMARK.err \
	--l1_cache_mode=$L1_CACHE_MODE \
	--l2_cache_mode=$L2_CACHE_MODE \
	--l1_hit_latency=2 \
	--l2_hit_latency=10 \
	--l2_miss_penalty=200 \
	--vdd3=1000 \
	--bit_faultrate3=1000000000000000000 \
	--vdd2=600 \
	--bit_faultrate2=5000000 \
	--vdd1=500 \
	--bit_faultrate1=12500 \
	--l1_access_energy_vdd3=0.0252 \
	--l1_access_energy_vdd2=0.0210 \
	--l1_access_energy_vdd1=0.0199 \
	--l2_access_energy_vdd3=0.1679 \
	--l2_access_energy_vdd2=0.1518 \
	--l2_access_energy_vdd1=0.1478 \
	--vdd_switch_overhead=20 \
	--dpcs_l1_sample_interval=100000 \
	--dpcs_l2_sample_interval=10000 \
	--dpcs_super_sample_interval=20 \
	--dpcs_l1_miss_threshold_low=0.05 \
	--dpcs_l1_miss_threshold_high=0.10 \
	--dpcs_l2_miss_threshold_low=0.05 \
	--dpcs_l2_miss_threshold_high=0.10 \
	| tee $SCRIPT_OUT
##################################################################
