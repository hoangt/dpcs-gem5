#!/bin/bash

echo "Starting job submission..."

# perlbench
qsub ./run_alpha_benchmark_uci_cluster_A.sh perlbench ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh perlbench ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh perlbench ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# bzip2
qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# gcc
qsub ./run_alpha_benchmark_uci_cluster_A.sh gcc ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh gcc ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh gcc ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# bwaves
qsub ./run_alpha_benchmark_uci_cluster_A.sh bwaves ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bwaves ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh bwaves ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# zeusmp
qsub ./run_alpha_benchmark_uci_cluster_A.sh zeusmp ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh zeusmp ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh zeusmp ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# gromacs
qsub ./run_alpha_benchmark_uci_cluster_A.sh gromacs ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh gromacs ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh gromacs ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# leslie3d
qsub ./run_alpha_benchmark_uci_cluster_A.sh leslie3d ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh leslie3d ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh leslie3d ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# namd
qsub ./run_alpha_benchmark_uci_cluster_A.sh namd ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh namd ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh namd ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A

# gobmk
qsub ./run_alpha_benchmark_uci_cluster_A.sh gobmk ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh gobmk ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh gobmk ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A

# povray
qsub ./run_alpha_benchmark_uci_cluster_A.sh povray ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh povray ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh povray ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A

# sjeng
qsub ./run_alpha_benchmark_uci_cluster_A.sh sjeng ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh sjeng ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh sjeng ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A

# GemsFDTD
qsub ./run_alpha_benchmark_uci_cluster_A.sh GemsFDTD ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh GemsFDTD ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A

qsub ./run_alpha_benchmark_uci_cluster_A.sh GemsFDTD ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A

# h264ref
qsub ./run_alpha_benchmark_uci_cluster_A.sh h264ref ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh h264ref ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh h264ref ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# lbm
qsub ./run_alpha_benchmark_uci_cluster_A.sh lbm ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh lbm ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh lbm ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# astar
qsub ./run_alpha_benchmark_uci_cluster_A.sh astar ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh astar ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh astar ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

# sphinx3
qsub ./run_alpha_benchmark_uci_cluster_A.sh sphinx3 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no baseline1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh sphinx3 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no static1_A 

qsub ./run_alpha_benchmark_uci_cluster_A.sh sphinx3 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-A.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-A.csv no dynamic1_A 

echo "Done submitting jobs!"
