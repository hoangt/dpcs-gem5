#!/bin/bash

echo "Starting..."

./run_alpha_benchmark_B.sh perlbench ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh perlbench ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh perlbench ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh bzip2 ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh bzip2 ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh bzip2 ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh gcc ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh gcc ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5

wait

./run_alpha_benchmark_B.sh gcc ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh bwaves ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh bwaves ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh bwaves ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh zeusmp ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh zeusmp ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh zeusmp ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh gromacs ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5

wait

./run_alpha_benchmark_B.sh gromacs ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh gromacs ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh leslie3d ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh leslie3d ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh leslie3d ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh namd ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh namd ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh namd ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

wait

./run_alpha_benchmark_B.sh gobmk ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh gobmk ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh gobmk ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh povray ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh povray ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh povray ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh sjeng ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh sjeng ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5

wait

./run_alpha_benchmark_B.sh sjeng ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh GemsFDTD ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh GemsFDTD ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh GemsFDTD ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh h264ref ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh h264ref ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh h264ref ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh lbm ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5

wait

./run_alpha_benchmark_B.sh lbm ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh lbm ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh astar ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh astar ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh astar ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

./run_alpha_benchmark_B.sh sphinx3 ref vanilla vanilla /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no baseline1_B &
sleep 5
./run_alpha_benchmark_B.sh sphinx3 ref static static /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no static1_B &
sleep 5
./run_alpha_benchmark_B.sh sphinx3 ref dynamic dynamic /home/mark/gem5/gem5params-L1-B.csv /home/mark/gem5/gem5params-L2-B.csv no dynamic1_B &
sleep 5

wait

echo "Done!"
