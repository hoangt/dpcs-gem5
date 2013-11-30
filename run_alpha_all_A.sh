#!/bin/bash

echo "Starting..."

./run_alpha_benchmark_A.sh perlbench ref vanilla vanilla gem5params-L1-A.csv gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh perlbench ref static static gem5params-L1-A.csv gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh perlbench ref dynamic dynamic gem5params-L1-A.csv gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh bzip2 ref vanilla vanilla gem5params-L1-A.csv gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh bzip2 ref static static gem5params-L1-A.csv gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh bzip2 ref dynamic dynamic gem5params-L1-A.csv gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh gcc ref vanilla vanilla gem5params-L1-A.csv gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh gcc ref static static gem5params-L1-A.csv gem5params-L2-A.csv no static1_A &
sleep 5
###################### FIX STARTING HERE ########################
wait

./run_alpha_benchmark_A.sh gcc ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh bwaves ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh bwaves ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh bwaves ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh zeusmp ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh zeusmp ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh zeusmp ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh gromacs ref vanilla vanilla baseline1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh gromacs ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh gromacs ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh leslie3d ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh leslie3d ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh leslie3d ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh namd ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh namd ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh namd ref dynamic dynamic dynamic1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh gobmk ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh gobmk ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh gobmk ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh povray ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh povray ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh povray ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh sjeng ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh sjeng ref static static static1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh sjeng ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh GemsFDTD ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh GemsFDTD ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh GemsFDTD ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh h264ref ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh h264ref ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh h264ref ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh lbm ref vanilla vanilla baseline1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh lbm ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh lbm ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh astar ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh astar ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh astar ref dynamic dynamic dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh sphinx3 ref vanilla vanilla baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh sphinx3 ref static static static1_A &
sleep 5
./run_alpha_benchmark_A.sh sphinx3 ref dynamic dynamic dynamic1_A &
sleep 5

wait

echo "Done!"
