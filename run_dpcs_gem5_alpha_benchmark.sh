#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

################## DIRECTORY VARIABLES: MODIFY ACCORDINGLY #######
GEM5_DIR=/u/home/puneet/mgottsch/dpcs-gem5					# Install location of gem5
SPEC_DIR=/u/home/puneet/mgottsch/spec_cpu2006_install		# Install location of your SPEC2006 benchmarks
##################################################################

ARGC=$# # Get number of arguments excluding arg0 (the script itself). Check for help message condition.
if [[ "$ARGC" != 9 ]]; then # Bad number of arguments. 
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "This script runs a single gem5 simulation of a single SPEC CPU2006 benchmark for Alpha ISA."
	echo ""
	echo "USAGE: run_dpcs_gem5_alpha_benchmark.sh <BENCHMARK> <L1_CACHE_MODE> <L2_CACHE_MODE> <GEM5_CONFIG_SUBSCRIPT> <L1_FAULT_MAP_CSV> <L2_FAULT_MAP_CSV> <L1_RUNTIME_VDD> <L2_RUNTIME_VDD> <OUTPUT_DIR>"
	echo "EXAMPLE: ./run_dpcs_gem5_alpha_benchmark.sh bzip2 vanilla vanilla /FULL/PATH/TO/gem5-config-subscript-foo.sh /FULL/PATH/TO/faultmap-L1-foo-1-1234.csv /FULL/PATH/TO/faultmap-L2-foo-1-2014.csv /FULL/PATH/TO/runtimevdd-L1-foo-1-1234.csv /FULL/PATH/TO/runtimevdd-L2-foo-1-2014.csv /FULL/PATH/TO/output_dir"
	echo ""
	echo "A single --help help or -h argument will bring this message back."
	exit
fi

# Get command line input. We will need to check these.
BENCHMARK=$1					# Benchmark name, e.g. bzip2
L1_CACHE_MODE=$2				# vanilla/static/dynamic cache -- L1
L2_CACHE_MODE=$3				# vanilla/static/dynamic cache -- L2
GEM5_CONFIG_SUBSCRIPT=$4		# full path to the gem5 configuration shell script
L1_FAULT_MAP_CSV=$5				# full path to the L1 fault map file for SPCS/DPCS modes
L2_FAULT_MAP_CSV=$6				# full path to the L2 fault map file for SPCS/DPCS modes
L1_RUNTIME_VDD_CSV=$7			# full path to the L1 runtime VDD file corresponding to the L1 fault map file for SPCS/DPCS modes
L2_RUNTIME_VDD_CSV=$8			# full path to the L2 runtime VDD file corresponding to the L2 fault map file for SPCS/DPCS modes
OUTPUT_DIR=$9					# Directory to place run output. Make sure this exists!

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

# Check BENCHMARK input
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
	echo "Input benchmark selection $BENCHMARK did not match any known SPEC CPU2006 benchmarks! Exiting."
	exit 1
fi
##################################################################

# Check L1_CACHE_MODE input
if [[ "$L1_CACHE_MODE" != "vanilla" && "$L1_CACHE_MODE" != "static" && "$L1_CACHE_MODE" != "dynamic" ]]; then
	echo "L1_CACHE_MODE needs to be either vanilla, static, or dynamic! Exiting."
	exit 1
fi

# Check L2_CACHE_MODE input
if [[ "$L2_CACHE_MODE" != "vanilla" && "$L2_CACHE_MODE" != "static" && "$L2_CACHE_MODE" != "dynamic" ]]; then
	echo "L2_CACHE_MODE needs to be either vanilla, static, or dynamic! Exiting."
	exit 1
fi

# Check that L1_FAULT_MAP_CSV file exists
if [[ !(-f "$L1_FAULT_MAP_CSV") ]]; then
	echo "gem5 L1 fault map file $L1_FAULT_MAP_CSV does not exist or is not a regular file! Exiting."
	exit 1
fi

# Check that L2_FAULT_MAP_CSV file exists
if [[ !(-f "$L2_FAULT_MAP_CSV") ]]; then
	echo "gem5 L2 fault map file $L2_FAULT_MAP_CSV does not exist or is not a regular file! Exiting."
	exit 1
fi

# Check that L1_RUNTIME_VDD_CSV file exists
if [[ !(-f "$L1_RUNTIME_VDD_CSV") ]]; then
	echo "gem5 L1 runtime VDD file $L1_RUNTIME_VDD_CSV does not exist or is not a regular file! Exiting."
	exit 1
fi

# Check that L2_RUNTIME_VDD_CSV file exists
if [[ !(-f "$L2_RUNTIME_VDD_CSV") ]]; then
	echo "gem5 L2 runtime VDD file $L2_RUNTIME_VDD_CSV does not exist or is not a regular file! Exiting."
	exit 1
fi

# Check OUTPUT_DIR existence
if [[ !(-d "$OUTPUT_DIR") ]]; then
	echo "Output directory $OUTPUT_DIR does not exist! Exiting."
	exit 1
fi

RUN_DIR=$SPEC_DIR/benchspec/CPU2006/$BENCHMARK_CODE/run/run_base_ref\_my-alpha.0000		# Run directory for the selected SPEC benchmark
SCRIPT_OUT=$OUTPUT_DIR/runscript.log															# File log for this script's stdout henceforth
L1I_CACHE_TRACE_CSV=$OUTPUT_DIR/l1i_cache_trace.csv
L1D_CACHE_TRACE_CSV=$OUTPUT_DIR/l1d_cache_trace.csv
L2_CACHE_TRACE_CSV=$OUTPUT_DIR/l2_cache_trace.csv

################## REPORT SCRIPT CONFIGURATION ###################

echo "Command line:"								| tee $SCRIPT_OUT
echo "$0 $*"										| tee -a $SCRIPT_OUT
echo "================= Hardcoded directories ==================" | tee -a $SCRIPT_OUT
echo "GEM5_DIR:                                     $GEM5_DIR" | tee -a $SCRIPT_OUT
echo "SPEC_DIR:                                     $SPEC_DIR" | tee -a $SCRIPT_OUT
echo "==================== Script inputs =======================" | tee -a $SCRIPT_OUT
echo "BENCHMARK:                                    $BENCHMARK" | tee -a $SCRIPT_OUT
echo "L1_CACHE_MODE:                                $L1_CACHE_MODE" | tee -a $SCRIPT_OUT
echo "L2_CACHE_MODE:                                $L2_CACHE_MODE" | tee -a $SCRIPT_OUT
echo "GEM5_CONFIG_SUBSCRIPT:                        $GEM5_CONFIG_SUBSCRIPT" | tee -a $SCRIPT_OUT
echo "L1_FAULT_MAP_CSV:                             $L1_FAULT_MAP_CSV" | tee -a $SCRIPT_OUT
echo "L2_FAULT_MAP_CSV:                             $L2_FAULT_MAP_CSV" | tee -a $SCRIPT_OUT
echo "L1_RUNTIME_VDD_CSV:                           $L1_RUNTIME_VDD_CSV" | tee -a $SCRIPT_OUT
echo "L2_RUNTIME_VDD_CSV:                           $L2_RUNTIME_VDD_CSV" | tee -a $SCRIPT_OUT
echo "L1I_CACHE_TRACE_CSV:							$L1I_CACHE_TRACE_CSV" | tee -a $SCRIPT_OUT
echo "L1D_CACHE_TRACE_CSV:							$L1D_CACHE_TRACE_CSV" | tee -a $SCRIPT_OUT
echo "L2_CACHE_TRACE_CSV:							$L2_CACHE_TRACE_CSV" | tee -a $SCRIPT_OUT
echo "OUTPUT_DIR:                                   $OUTPUT_DIR" | tee -a $SCRIPT_OUT
echo "==========================================================" | tee -a $SCRIPT_OUT
##################################################################


#################### LAUNCH GEM5 SIMULATION ######################
echo ""
echo "Changing to SPEC benchmark runtime directory:	$RUN_DIR" | tee -a $SCRIPT_OUT
cd $RUN_DIR

echo "" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT
echo "--------- Here goes nothing! Starting gem5! ------------" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT

# Actually launch gem5. We trust the subscript completely that you write. Please don't do something silly.
source $GEM5_CONFIG_SUBSCRIPT | tee -a $SCRIPT_OUT
