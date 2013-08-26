#!/bin/bash

#build/ALPHA/gem5.opt configs/example/se.py -c tests/test-progs/hello/bin/alpha/linux/hello

GEM5_DIR=/home/mark/gem5
SPEC_DIR=/home/mark/spec_cpu2006_install
BENCH_DIR=$SPEC_DIR/benchspec/CPU2006
GEM5OUT_DIR=$GEM5_DIR/m5out

PERLBENCH_CODE=400.perlbench
BZIP2_CODE=401.bzip2
GCC_CODE=403.gcc
BWAVES_CODE=410.bwaves
MCF_CODE=429.mcf
NAMD_CODE=444.namd
POVRAY_CODE=453.povray
SPECRAND_INT_CODE=998.specrand
SPECRAND_FLOAT_CODE=999.specrand

# Add more benchmark directories as supported

BENCHMARK=$1 # User input for benchmark name, e.g. bzip2

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
if [[ "$BENCHMARK" == "mcf" ]]; then
	BENCHMARK_CODE=$MCF_CODE
fi
if [[ "$BENCHMARK" == "namd" ]]; then
	BENCHMARK_CODE=$NAMD_CODE
fi
if [[ "$BENCHMARK" == "povray" ]]; then
	BENCHMARK_CODE=$POVRAY_CODE
fi
if [[ "$BENCHMARK" == "specrand_i" ]]; then
	BENCHMARK_CODE=$SPECRAND_INT_CODE
fi
if [[ "$BENCHMARK" == "specrand_f" ]]; then
	BENCHMARK_CODE=$SPECRAND_FLOAT_CODE
fi

BENCHMARK_DIR=$BENCH_DIR/$BENCHMARK_CODE
RUN_DIR=$BENCHMARK_DIR/run/run_base_test_alpha.0000

echo "=============================================="
echo "Selected benchmark:" $BENCHMARK
echo "SPEC_DIR:" $SPEC_DIR
echo "BENCH_DIR:" $BENCH_DIR
echo "BENCHMARK:" $BENCHMARK
echo "BENCHMARK_CODE:" $BENCHMARK_CODE
echo "BENCHMARK_DIR:" $BENCHMARK_DIR
echo "RUN_DIR:" $RUN_DIR
echo "=============================================="

echo "Changing to directory:	$RUN_DIR"
cd $RUN_DIR
echo -e "Starting gem5......\n\n\n"

$GEM5_DIR/build/ALPHA/gem5.opt --outdir=$GEM5OUT_DIR $GEM5_DIR/configs/example/myconfig.py --cpu-type=AtomicSimpleCPU --num-cpus=1 --sys-clock="3GHz" --cpu-clock="3GHz" --mem-type=SimpleMemory --mem-channels=1 --mem-size="4096MB" --caches --l2cache --num-l2caches=1 --num-l3caches=0 --l1d_size="64kB" --l1i_size="64kB" --l2_size="2MB" --l1d_assoc=4 --l1i_assoc=4 --l2_assoc=8 --cacheline_size="64" --benchmark=$BENCHMARK
