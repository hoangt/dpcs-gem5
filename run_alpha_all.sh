#!/bin/bash

# ./run_alpha_benchmark.sh <BENCHMARK> <DATA_SIZE> <CACHE_MODE> <RUN_NAME>
./run_alpha_benchmark.sh perlbench ref vanilla baseline &
./run_alpha_benchmark.sh perlbench ref dpcs dpcs1 &
./run_alpha_benchmark.sh perlbench ref dpcs dpcs2 &
./run_alpha_benchmark.sh perlbench ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh bzip2 ref vanilla baseline
./run_alpha_benchmark.sh bzip2 ref dpcs dpcs1 &
./run_alpha_benchmark.sh bzip2 ref dpcs dpcs2 &
./run_alpha_benchmark.sh bzip2 ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh gcc ref vanilla baseline
./run_alpha_benchmark.sh gcc ref dpcs dpcs1 &
./run_alpha_benchmark.sh gcc ref dpcs dpcs2 &
./run_alpha_benchmark.sh gcc ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh bwaves ref vanilla baseline
./run_alpha_benchmark.sh bwaves ref dpcs dpcs1 &
./run_alpha_benchmark.sh bwaves ref dpcs dpcs2 &
./run_alpha_benchmark.sh bwaves ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh gamess ref vanilla baseline
./run_alpha_benchmark.sh gamess ref dpcs dpcs1 &
./run_alpha_benchmark.sh gamess ref dpcs dpcs2 &
./run_alpha_benchmark.sh gamess ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh mcf ref vanilla baseline
./run_alpha_benchmark.sh mcf ref dpcs dpcs1 &
./run_alpha_benchmark.sh mcf ref dpcs dpcs2 &
./run_alpha_benchmark.sh mcf ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh milc ref vanilla baseline
./run_alpha_benchmark.sh milc ref dpcs dpcs1 &
./run_alpha_benchmark.sh milc ref dpcs dpcs2 &
./run_alpha_benchmark.sh milc ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh zeusmp ref vanilla baseline
./run_alpha_benchmark.sh zeusmp ref dpcs dpcs1 &
./run_alpha_benchmark.sh zeusmp ref dpcs dpcs2 &
./run_alpha_benchmark.sh zeusmp ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh gromacs ref vanilla baseline
./run_alpha_benchmark.sh gromacs ref dpcs dpcs1 &
./run_alpha_benchmark.sh gromacs ref dpcs dpcs2 &
./run_alpha_benchmark.sh gromacs ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh cactusADM ref vanilla baseline
./run_alpha_benchmark.sh cactusADM ref dpcs dpcs1 &
./run_alpha_benchmark.sh cactusADM ref dpcs dpcs2 &
./run_alpha_benchmark.sh cactusADM ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh leslie3d ref vanilla baseline
./run_alpha_benchmark.sh leslie3d ref dpcs dpcs1 &
./run_alpha_benchmark.sh leslie3d ref dpcs dpcs2 &
./run_alpha_benchmark.sh leslie3d ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh namd ref vanilla baseline
./run_alpha_benchmark.sh namd ref dpcs dpcs1 &
./run_alpha_benchmark.sh namd ref dpcs dpcs2 &
./run_alpha_benchmark.sh namd ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh gobmk ref vanilla baseline
./run_alpha_benchmark.sh gobmk ref dpcs dpcs1 &
./run_alpha_benchmark.sh gobmk ref dpcs dpcs2 &
./run_alpha_benchmark.sh gobmk ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh dealII ref vanilla baseline
./run_alpha_benchmark.sh dealII ref dpcs dpcs1 &
./run_alpha_benchmark.sh dealII ref dpcs dpcs2 &
./run_alpha_benchmark.sh dealII ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh soplex ref vanilla baseline
./run_alpha_benchmark.sh soplex ref dpcs dpcs1 &
./run_alpha_benchmark.sh soplex ref dpcs dpcs2 &
./run_alpha_benchmark.sh soplex ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh povray ref vanilla baseline
./run_alpha_benchmark.sh povray ref dpcs dpcs1 &
./run_alpha_benchmark.sh povray ref dpcs dpcs2 &
./run_alpha_benchmark.sh povray ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh calculix ref vanilla baseline
./run_alpha_benchmark.sh calculix ref dpcs dpcs1 &
./run_alpha_benchmark.sh calculix ref dpcs dpcs2 &
./run_alpha_benchmark.sh calculix ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh hmmer ref vanilla baseline
./run_alpha_benchmark.sh hmmer ref dpcs dpcs1 &
./run_alpha_benchmark.sh hmmer ref dpcs dpcs2 &
./run_alpha_benchmark.sh hmmer ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh sjeng ref vanilla baseline
./run_alpha_benchmark.sh sjeng ref dpcs dpcs1 &
./run_alpha_benchmark.sh sjeng ref dpcs dpcs2 &
./run_alpha_benchmark.sh sjeng ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh GemsFDTD ref vanilla baseline
./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs1 &
./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs2 &
./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh libquantum ref vanilla baseline
./run_alpha_benchmark.sh libquantum ref dpcs dpcs1 &
./run_alpha_benchmark.sh libquantum ref dpcs dpcs2 &
./run_alpha_benchmark.sh libquantum ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh h264ref ref vanilla baseline
./run_alpha_benchmark.sh h264ref ref dpcs dpcs1 &
./run_alpha_benchmark.sh h264ref ref dpcs dpcs2 &
./run_alpha_benchmark.sh h264ref ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh tonto ref vanilla baseline
./run_alpha_benchmark.sh tonto ref dpcs dpcs1 &
./run_alpha_benchmark.sh tonto ref dpcs dpcs2 &
./run_alpha_benchmark.sh tonto ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh lbm ref vanilla baseline
./run_alpha_benchmark.sh lbm ref dpcs dpcs1 &
./run_alpha_benchmark.sh lbm ref dpcs dpcs2 &
./run_alpha_benchmark.sh lbm ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh omnetpp ref vanilla baseline
./run_alpha_benchmark.sh omnetpp ref dpcs dpcs1 &
./run_alpha_benchmark.sh omnetpp ref dpcs dpcs2 &
./run_alpha_benchmark.sh omnetpp ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh astar ref vanilla baseline
./run_alpha_benchmark.sh astar ref dpcs dpcs1 &
./run_alpha_benchmark.sh astar ref dpcs dpcs2 &
./run_alpha_benchmark.sh astar ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh wrf ref vanilla baseline
./run_alpha_benchmark.sh wrf ref dpcs dpcs1 &
./run_alpha_benchmark.sh wrf ref dpcs dpcs2 &
./run_alpha_benchmark.sh wrf ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh sphinx3 ref vanilla baseline
./run_alpha_benchmark.sh sphinx3 ref dpcs dpcs1 &
./run_alpha_benchmark.sh sphinx3 ref dpcs dpcs2 &
./run_alpha_benchmark.sh sphinx3 ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh xalancbmk ref vanilla baseline
./run_alpha_benchmark.sh xalancbmk ref dpcs dpcs1 &
./run_alpha_benchmark.sh xalancbmk ref dpcs dpcs2 &
./run_alpha_benchmark.sh xalancbmk ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh specrand_i ref vanilla baseline
./run_alpha_benchmark.sh specrand_i ref dpcs dpcs1 &
./run_alpha_benchmark.sh specrand_i ref dpcs dpcs2 &
./run_alpha_benchmark.sh specrand_i ref dpcs dpcs3 &
wait

./run_alpha_benchmark.sh specrand_f ref vanilla baseline
./run_alpha_benchmark.sh specrand_f ref dpcs dpcs1 &
./run_alpha_benchmark.sh specrand_f ref dpcs dpcs2 &
./run_alpha_benchmark.sh specrand_f ref dpcs dpcs3 &
wait
