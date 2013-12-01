#!/bin/bash

echo "Starting..."

./run_alpha_benchmark_A.sh perlbench ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh perlbench ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh perlbench ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh bzip2 ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh bzip2 ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh bzip2 ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh gcc ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh gcc ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh gcc ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh bwaves ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh bwaves ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh bwaves ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh zeusmp ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh zeusmp ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh zeusmp ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh gromacs ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh gromacs ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh gromacs ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh leslie3d ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh leslie3d ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh leslie3d ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh namd ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh namd ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh namd ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh gobmk ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh gobmk ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh gobmk ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh povray ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh povray ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh povray ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh sjeng ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh sjeng ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh sjeng ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh GemsFDTD ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh GemsFDTD ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh GemsFDTD ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh h264ref ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh h264ref ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh h264ref ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh lbm ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5

wait

./run_alpha_benchmark_A.sh lbm ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh lbm ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh astar ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh astar ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh astar ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

./run_alpha_benchmark_A.sh sphinx3 ref vanilla vanilla /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no baseline1_A &
sleep 5
./run_alpha_benchmark_A.sh sphinx3 ref static static /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no static1_A &
sleep 5
./run_alpha_benchmark_A.sh sphinx3 ref dynamic dynamic /home/mark/gem5/gem5params-L1-A.csv /home/mark/gem5/gem5params-L2-A.csv no dynamic1_A &
sleep 5

wait

echo "Done!"
