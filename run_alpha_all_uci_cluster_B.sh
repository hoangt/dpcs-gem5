#!/bin/bash
#$ -q pub64

echo "Starting job submission..."

# perlbench
qsub ./run_alpha_benchmark_uci_cluster_B.sh perlbench ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 

#qsub ./run_alpha_benchmark_uci_cluster_B.sh perlbench ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh perlbench ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## bzip2
#qsub ./run_alpha_benchmark_uci_cluster_B.sh bzip2 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh bzip2 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh bzip2 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## gcc
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gcc ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gcc ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gcc ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## bwaves
#qsub ./run_alpha_benchmark_uci_cluster_B.sh bwaves ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh bwaves ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh bwaves ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## zeusmp
#qsub ./run_alpha_benchmark_uci_cluster_B.sh zeusmp ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh zeusmp ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh zeusmp ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## gromacs
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gromacs ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gromacs ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gromacs ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## leslie3d
#qsub ./run_alpha_benchmark_uci_cluster_B.sh leslie3d ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh leslie3d ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh leslie3d ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## namd
#qsub ./run_alpha_benchmark_uci_cluster_B.sh namd ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh namd ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh namd ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B
#
## gobmk
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gobmk ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gobmk ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh gobmk ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B
#
## povray
#qsub ./run_alpha_benchmark_uci_cluster_B.sh povray ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh povray ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh povray ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B
#
## sjeng
#qsub ./run_alpha_benchmark_uci_cluster_B.sh sjeng ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh sjeng ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh sjeng ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B
#
## GemsFDTD
#qsub ./run_alpha_benchmark_uci_cluster_B.sh GemsFDTD ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh GemsFDTD ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh GemsFDTD ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B
#
## h264ref
#qsub ./run_alpha_benchmark_uci_cluster_B.sh h264ref ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh h264ref ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh h264ref ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## lbm
#qsub ./run_alpha_benchmark_uci_cluster_B.sh lbm ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh lbm ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh lbm ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## astar
#qsub ./run_alpha_benchmark_uci_cluster_B.sh astar ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh astar ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh astar ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 
#
## sphinx3
#qsub ./run_alpha_benchmark_uci_cluster_B.sh sphinx3 ref vanilla vanilla /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no baseline1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh sphinx3 ref static static /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no static1_B 
#
#qsub ./run_alpha_benchmark_uci_cluster_B.sh sphinx3 ref dynamic dynamic /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L1-B.csv /data/users/abanaiya/gem5/gem5-mgottscho/gem5params-L2-B.csv no dynamic1_B 

echo "Done submitting jobs!"
