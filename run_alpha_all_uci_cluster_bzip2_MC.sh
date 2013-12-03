#!/bin/bash

echo "Starting job submission..."

# bzip2 runset 1
qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic1_A 

# bzip2 runset 2
qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline2_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static2_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic2_A 

# bzip2 runset 3
qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline3_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static3_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic3_A 

# bzip2 runset 4
qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline4_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static4_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic4_A 

# bzip2 runset 5
qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_baseline5_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_static5_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no mc_dynamic5_A 
echo "Done submitting jobs!"
