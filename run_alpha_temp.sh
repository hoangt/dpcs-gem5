#!/bin/bash

./run_alpha_benchmark.sh perlbench ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh perlbench ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh perlbench ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh perlbench ref dpcs dpcs dpcs3 &
sleep 5

echo "Done!"
