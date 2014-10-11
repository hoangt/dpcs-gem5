$GEM5_DIR/build/ALPHA/gem5.fast\
 \
 --outdir=$OUTPUT_DIR\
 \
 $GEM5_DIR/configs/example/spec06_config.py\
 \
 --cpu-type=detailed\
 --num-cpus=1\
 --sys-clock="3GHz"\
 --cpu-clock="3GHz"\
 --sys-voltage="1V"\
 \
 --caches\
 --cacheline_size="64"\
 \
 --l1d_size="256kB"\
 --l1i_size="256kB"\
 --l1d_assoc=8\
 --l1i_assoc=8\
 --l1_hit_latency=3\
 --l1_cache_mode=$L1_CACHE_MODE\
 --l1_fault_map_file=$L1_FAULT_MAP_CSV\
 --l1_runtime_vdd_select_file=$L1_RUNTIME_VDD_CSV\
 --dpcs_l1_sample_interval=122400\
 --dpcs_l1_threshold_low=0.15\
 --dpcs_l1_threshold_high=0.25\
 --dpcs_l1_vdd_switch_overhead=200\
 \
 --l2cache\
 --num-l2caches=1\
 --l2_size="8MB"\
 --l2_assoc=16\
 --l2_hit_latency=8\
 --l2_cache_mode=$L2_CACHE_MODE\
 --l2_fault_map_file=$L2_FAULT_MAP_CSV\
 --l2_runtime_vdd_select_file=$L2_RUNTIME_VDD_CSV\
 --dpcs_l2_sample_interval=1838400\
 --dpcs_l2_threshold_low=0.15\
 --dpcs_l2_threshold_high=0.25\
 --dpcs_l2_vdd_switch_overhead=2000\
 \
 --num-l3caches=0\
 \
 --mem-type=ddr3_1600_x64\
 --mem-channels=1\
 --mem-size="2048MB"\
 \
 --benchmark=$BENCHMARK\
 --benchmark_stdout=$OUTPUT_DIR/$BENCHMARK.out\
 --benchmark_stderr=$OUTPUT_DIR/$BENCHMARK.err\
 \
 --fast-forward=2000000000\
 --maxinsts=4000000000\
 --at-instruction
