#!/bin/bash

echo "Starting..."

./run_alpha_benchmark_v1.sh perlbench ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh perlbench ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh perlbench ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh bzip2 ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh bzip2 ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh bzip2 ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh gcc ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh gcc ref static static static1_v1 &
sleep 5

wait

./run_alpha_benchmark_v1.sh gcc ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh bwaves ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh bwaves ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh bwaves ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh zeusmp ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh zeusmp ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh zeusmp ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh gromacs ref vanilla vanilla baseline1_v1 &
sleep 5

wait

./run_alpha_benchmark_v1.sh gromacs ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh gromacs ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh leslie3d ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh leslie3d ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh leslie3d ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh namd ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh namd ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh namd ref dynamic dynamic dynamic1_v1 &
sleep 5

wait

./run_alpha_benchmark_v1.sh gobmk ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh gobmk ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh gobmk ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh povray ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh povray ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh povray ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh sjeng ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh sjeng ref static static static1_v1 &
sleep 5

wait

./run_alpha_benchmark_v1.sh sjeng ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh GemsFDTD ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh GemsFDTD ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh GemsFDTD ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh h264ref ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh h264ref ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh h264ref ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh lbm ref vanilla vanilla baseline1_v1 &
sleep 5

wait

./run_alpha_benchmark_v1.sh lbm ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh lbm ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh astar ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh astar ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh astar ref dynamic dynamic dynamic1_v1 &
sleep 5

./run_alpha_benchmark_v1.sh sphinx3 ref vanilla vanilla baseline1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh sphinx3 ref static static static1_v1 &
sleep 5
./run_alpha_benchmark_v1.sh sphinx3 ref dynamic dynamic dynamic1_v1 &
sleep 5

wait

echo "Done!"
