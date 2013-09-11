#!/bin/bash

echo "Starting..."

./run_alpha_benchmark_v1.sh perlbench ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh perlbench ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh perlbench ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh perlbench ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark_v1.sh bzip2 ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh bzip2 ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh bzip2 ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh bzip2 ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark_v1.sh gcc ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh gcc ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh gcc ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh gcc ref dpcs dpcs dpcs3 &
sleep 5

./run_alpha_benchmark_v1.sh bwaves ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh bwaves ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh bwaves ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh bwaves ref dpcs dpcs dpcs3 &
sleep 5

wait

#./run_alpha_benchmark_v1.sh gamess ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh gamess ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh gamess ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh gamess ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark_v1.sh mcf ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh mcf ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh mcf ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh mcf ref dpcs dpcs dpcs3 &
sleep 5
#
#wait
#
#./run_alpha_benchmark_v1.sh milc ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh milc ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh milc ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh milc ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark_v1.sh zeusmp ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh zeusmp ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh zeusmp ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh zeusmp ref dpcs dpcs dpcs3 &
sleep 5
#
#wait
#
./run_alpha_benchmark_v1.sh gromacs ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh gromacs ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh gromacs ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh gromacs ref dpcs dpcs dpcs3 &
sleep 5
#
#./run_alpha_benchmark_v1.sh cactusADM ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh cactusADM ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh cactusADM ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh cactusADM ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
./run_alpha_benchmark_v1.sh leslie3d ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh leslie3d ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh leslie3d ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh leslie3d ref dpcs dpcs dpcs3 &
sleep 5

wait

#
./run_alpha_benchmark_v1.sh namd ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh namd ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh namd ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh namd ref dpcs dpcs dpcs3 &
sleep 5
#
#wait
#
./run_alpha_benchmark_v1.sh gobmk ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh gobmk ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh gobmk ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh gobmk ref dpcs dpcs dpcs3 &
sleep 5
#
# DOES NOT WORK
#./run_alpha_benchmark_v1.sh dealII ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh dealII ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh dealII ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh dealII ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark_v1.sh soplex ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh soplex ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh soplex ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh soplex ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark_v1.sh povray ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh povray ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh povray ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh povray ref dpcs dpcs dpcs3 &
sleep 5

#
#./run_alpha_benchmark_v1.sh calculix ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh calculix ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh calculix ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh calculix ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark_v1.sh hmmer ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh hmmer ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh hmmer ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh hmmer ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
./run_alpha_benchmark_v1.sh sjeng ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh sjeng ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh sjeng ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh sjeng ref dpcs dpcs dpcs3 &
sleep 5

wait

#
./run_alpha_benchmark_v1.sh GemsFDTD ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh GemsFDTD ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh GemsFDTD ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh GemsFDTD ref dpcs dpcs dpcs3 &
sleep 5

#
#./run_alpha_benchmark_v1.sh libquantum ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh libquantum ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh libquantum ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh libquantum ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark_v1.sh h264ref ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh h264ref ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh h264ref ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh h264ref ref dpcs dpcs dpcs3 &
sleep 5

#wait
#
#./run_alpha_benchmark_v1.sh tonto ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh tonto ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh tonto ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh tonto ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark_v1.sh lbm ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh lbm ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh lbm ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh lbm ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark_v1.sh omnetpp ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh omnetpp ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh omnetpp ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh omnetpp ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark_v1.sh astar ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh astar ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh astar ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh astar ref dpcs dpcs dpcs3 &
sleep 5
#
#wait
#
#./run_alpha_benchmark_v1.sh wrf ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh wrf ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh wrf ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh wrf ref dpcs dpcs dpcs3 &
#sleep 5
#
./run_alpha_benchmark_v1.sh sphinx3 ref vanilla vanilla baseline &
sleep 5
./run_alpha_benchmark_v1.sh sphinx3 ref dpcs dpcs dpcs1 &
sleep 5
./run_alpha_benchmark_v1.sh sphinx3 ref dpcs dpcs dpcs2 &
sleep 5
./run_alpha_benchmark_v1.sh sphinx3 ref dpcs dpcs dpcs3 &
sleep 5

wait

# DOES NOT WORK
#./run_alpha_benchmark_v1.sh xalancbmk ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh xalancbmk ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh xalancbmk ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh xalancbmk ref dpcs dpcs dpcs3 &
#sleep 5
#
#./run_alpha_benchmark_v1.sh specrand_i ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh specrand_i ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh specrand_i ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh specrand_i ref dpcs dpcs dpcs3 &
#sleep 5
#
#wait
#
#./run_alpha_benchmark_v1.sh specrand_f ref vanilla vanilla baseline &
#sleep 5
#./run_alpha_benchmark_v1.sh specrand_f ref dpcs dpcs dpcs1 &
#sleep 5
#./run_alpha_benchmark_v1.sh specrand_f ref dpcs dpcs dpcs2 &
#sleep 5
#./run_alpha_benchmark_v1.sh specrand_f ref dpcs dpcs dpcs3 &
#sleep 5
#wait

echo "Done!"
