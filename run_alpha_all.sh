#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

####################### YOUR OPTIONS HERE ###################################
CONFIG_ID=A # String identifier for the system configuration, e.g. A or B
RUN_NUMBER=1 # Run number string
GEM5_L1_CONFIG_CSV=gem5params-L1-$CONFIG_ID.csv # Location of the L1 configuration CSV file
GEM5_L2_CONFIG_CSV=gem5params-L2-$CONFIG_ID.csv # Location of the L2 configuration CSV file
#############################################################################


BASELINE_STRING=baseline_$CONFIG_ID\_$RUN_NUMBER
STATIC_STRING=static_$CONFIG_ID\_$RUN_NUMBER
DYNAMIC_STRING=dynamic_$CONFIG_ID\_$RUN_NUMBER

echo "Starting gem5 runs..."

# perlbench
qsub ./run_alpha_benchmark_$CONFIG_ID.sh perlbench ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh perlbench ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh perlbench ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# bzip2
qsub ./run_alpha_benchmark_$CONFIG_ID.sh bzip2 ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh bzip2 ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh bzip2 ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# gcc
qsub ./run_alpha_benchmark_$CONFIG_ID.sh gcc ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh gcc ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh gcc ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# bwaves
qsub ./run_alpha_benchmark_$CONFIG_ID.sh bwaves ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh bwaves ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh bwaves ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# zeusmp
qsub ./run_alpha_benchmark_$CONFIG_ID.sh zeusmp ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh zeusmp ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh zeusmp ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# gromacs
qsub ./run_alpha_benchmark_$CONFIG_ID.sh gromacs ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh gromacs ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh gromacs ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# leslie3d
qsub ./run_alpha_benchmark_$CONFIG_ID.sh leslie3d ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh leslie3d ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh leslie3d ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# namd
qsub ./run_alpha_benchmark_$CONFIG_ID.sh namd ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh namd ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh namd ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING

# gobmk
qsub ./run_alpha_benchmark_$CONFIG_ID.sh gobmk ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh gobmk ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh gobmk ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING

# povray
qsub ./run_alpha_benchmark_$CONFIG_ID.sh povray ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh povray ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh povray ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING

# sjeng
qsub ./run_alpha_benchmark_$CONFIG_ID.sh sjeng ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh sjeng ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh sjeng ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING

# GemsFDTD
qsub ./run_alpha_benchmark_$CONFIG_ID.sh GemsFDTD ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh GemsFDTD ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING

qsub ./run_alpha_benchmark_$CONFIG_ID.sh GemsFDTD ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING

# h264ref
qsub ./run_alpha_benchmark_$CONFIG_ID.sh h264ref ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh h264ref ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh h264ref ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# lbm
qsub ./run_alpha_benchmark_$CONFIG_ID.sh lbm ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh lbm ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh lbm ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# astar
qsub ./run_alpha_benchmark_$CONFIG_ID.sh astar ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh astar ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh astar ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

# sphinx3
qsub ./run_alpha_benchmark_$CONFIG_ID.sh sphinx3 ref vanilla vanilla $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $BASELINE_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh sphinx3 ref static static $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $STATIC_STRING 

qsub ./run_alpha_benchmark_$CONFIG_ID.sh sphinx3 ref dynamic dynamic $GEM5_L1_CONFIG_CSV $GEM5_L2_CONFIG_CSV no $DYNAMIC_STRING 

echo "Done submitting jobs!"

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
