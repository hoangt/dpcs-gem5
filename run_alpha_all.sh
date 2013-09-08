#!/bin/bash

echo "Starting..."

./run_alpha_benchmark.sh perlbench ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh perlbench ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh perlbench ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh perlbench ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark.sh bzip2 ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh bzip2 ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh bzip2 ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh bzip2 ref dpcs dpcs dpcs3 &
sleep 5

wait

./run_alpha_benchmark.sh gcc ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh gcc ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh gcc ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh gcc ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark.sh bwaves ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh bwaves ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh bwaves ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh bwaves ref dpcs dpcs dpcs3 &
sleep 5

wait

#./run_alpha_benchmark.sh gamess ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh gamess ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh gamess ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh gamess ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh mcf ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh mcf ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh mcf ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh mcf ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh milc ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh milc ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh milc ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh milc ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh zeusmp ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh zeusmp ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh zeusmp ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh zeusmp ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh gromacs ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh gromacs ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh gromacs ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh gromacs ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh cactusADM ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh cactusADM ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh cactusADM ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh cactusADM ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
./run_alpha_benchmark.sh leslie3d ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh leslie3d ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh leslie3d ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh leslie3d ref dpcs dpcs dpcs3 &
sleep 5
#
#./run_alpha_benchmark.sh namd ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh namd ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh namd ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh namd ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh gobmk ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh gobmk ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh gobmk ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh gobmk ref dpcs dpcs dpcs3 &
#sleep 5
#
# DOES NOT WORK
#./run_alpha_benchmark.sh dealII ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh dealII ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh dealII ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh dealII ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh soplex ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh soplex ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh soplex ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh soplex ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark.sh povray ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh povray ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh povray ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh povray ref dpcs dpcs dpcs3 &
sleep 5

wait
#
#./run_alpha_benchmark.sh calculix ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh calculix ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh calculix ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh calculix ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh hmmer ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh hmmer ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh hmmer ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh hmmer ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh sjeng ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh sjeng ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh sjeng ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh sjeng ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh GemsFDTD ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh GemsFDTD ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh libquantum ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh libquantum ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh libquantum ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh libquantum ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark.sh h264ref ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh h264ref ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh h264ref ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh h264ref ref dpcs dpcs dpcs3 &
sleep 5

#wait
#
#./run_alpha_benchmark.sh tonto ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh tonto ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh tonto ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh tonto ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh lbm ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh lbm ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh lbm ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh lbm ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh omnetpp ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh omnetpp ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh omnetpp ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh omnetpp ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh astar ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh astar ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh astar ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh astar ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh wrf ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh wrf ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh wrf ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh wrf ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark.sh sphinx3 ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark.sh sphinx3 ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark.sh sphinx3 ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark.sh sphinx3 ref dpcs dpcs dpcs3 &
sleep 5

wait
# DOES NOT WORK
#./run_alpha_benchmark.sh xalancbmk ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh xalancbmk ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh xalancbmk ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh xalancbmk ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark.sh specrand_i ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh specrand_i ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh specrand_i ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh specrand_i ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark.sh specrand_f ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark.sh specrand_f ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark.sh specrand_f ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark.sh specrand_f ref dpcs dpcs dpcs3 &
#sleep 5
#wait

echo "Done!"
