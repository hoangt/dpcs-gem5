#!/bin/bash

./run_alpha_benchmark.sh mcf ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh mcf ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh mcf ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh mcf ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark.sh gobmk ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh gobmk ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh gobmk ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh gobmk ref dpcs dpcs dpcs3 &
sleep 5
wait

./run_alpha_benchmark.sh sjeng ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh sjeng ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh sjeng ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh sjeng ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark.sh astar ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh astar ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh astar ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh astar ref dpcs dpcs dpcs3 &
sleep 5
wait

./run_alpha_benchmark.sh zeusmp ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh zeusmp ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh zeusmp ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh zeusmp ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark.sh gromacs ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh gromacs ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh gromacs ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh gromacs ref dpcs dpcs dpcs3 &
sleep 5
wait

./run_alpha_benchmark.sh namd ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh namd ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh namd ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh namd ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark.sh GemsFDTD ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs dpcs3 &
sleep 5
wait
