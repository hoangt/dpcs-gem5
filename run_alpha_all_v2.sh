#!/bin/bash

echo "Starting..."

./run_alpha_benchmark_v2.sh perlbench ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh perlbench ref static static static_v2 &
sleep 5
./run_alpha_benchmark_v2.sh perlbench ref dynamic dynamic dynamic_v2 &
sleep 5

./run_alpha_benchmark_v2.sh bzip2 ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh bzip2 ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh bzip2 ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh gcc ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh gcc ref static static static1_v2 &
sleep 5

wait

./run_alpha_benchmark_v2.sh gcc ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh bwaves ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh bwaves ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh bwaves ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh zeusmp ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh zeusmp ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh zeusmp ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh gromacs ref vanilla vanilla baseline_v2 &
sleep 5

wait

./run_alpha_benchmark_v2.sh gromacs ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh gromacs ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh leslie3d ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh leslie3d ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh leslie3d ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh namd ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh namd ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh namd ref dynamic dynamic dynamic2_v2 &
sleep 5

wait

./run_alpha_benchmark_v2.sh gobmk ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh gobmk ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh gobmk ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh povray ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh povray ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh povray ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh sjeng ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh sjeng ref static static static1_v2 &
sleep 5

wait

./run_alpha_benchmark_v2.sh sjeng ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh GemsFDTD ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh GemsFDTD ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh GemsFDTD ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh h264ref ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh h264ref ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh h264ref ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh lbm ref vanilla vanilla baseline_v2 &
sleep 5

wait

./run_alpha_benchmark_v2.sh lbm ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh lbm ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh astar ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh astar ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh astar ref dynamic dynamic dynamic2_v2 &
sleep 5

./run_alpha_benchmark_v2.sh sphinx3 ref vanilla vanilla baseline_v2 &
sleep 5
./run_alpha_benchmark_v2.sh sphinx3 ref static static static1_v2 &
sleep 5
./run_alpha_benchmark_v2.sh sphinx3 ref dynamic dynamic dynamic2_v2 &
sleep 5

wait

echo "Done!"
