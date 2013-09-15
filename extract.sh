#!/bin/bash

dir=$1
cd $dir

grep "sim_seconds" stats.txt
#grep "system.switch_cpus.numCycles" stats.txt
echo "---------------------------------------------"
#grep "system.cpu.dcache.overall_accesses::total" stats.txt
#grep "system.cpu.dcache.overall_miss_rate::total" stats.txt
#grep "system.cpu.dcache.tags.numFaultyBlocks_VDD1" stats.txt
#grep "system.cpu.dcache.tags.numFaultyBlocks_VDD2" stats.txt
#grep "system.cpu.dcache.tags.numFaultyBlocks_VDD3" stats.txt
#grep "system.cpu.dcache.tags.accessEnergy_VDD1" stats.txt
#grep "system.cpu.dcache.tags.accessEnergy_VDD2" stats.txt
#grep "system.cpu.dcache.tags.accessEnergy_VDD3" stats.txt
grep "system.cpu.dcache.tags.accessEnergy_tot" stats.txt
#grep "system.cpu.dcache.tags.transitionsTo_VDD1" stats.txt
#grep "system.cpu.dcache.tags.transitionsTo_VDD2" stats.txt
#grep "system.cpu.dcache.tags.transitionsTo_VDD3" stats.txt
#grep "system.cpu.dcache.tags.proportionExecTime_VDD1" stats.txt
#grep "system.cpu.dcache.tags.proportionExecTime_VDD2" stats.txt
#grep "system.cpu.dcache.tags.proportionExecTime_VDD3" stats.txt
grep "system.cpu.dcache.tags.staticPower_avg" stats.txt
echo "---------------------------------------------"
#grep "system.l2.overall_accesses::total" stats.txt
#grep "system.l2.overall_miss_rate" stats.txt
#grep "NumFaultyBlocks_VDD" runscript.log
#grep "system.l2.tags.accessEnergy_VDD1" stats.txt
#grep "system.l2.tags.accessEnergy_VDD2" stats.txt
#grep "system.l2.tags.accessEnergy_VDD3" stats.txt
grep "system.l2.tags.accessEnergy_tot" stats.txt
#grep "system.l2.tags.transitionsTo_VDD1" stats.txt
#grep "system.l2.tags.transitionsTo_VDD2" stats.txt
#grep "system.l2.tags.transitionsTo_VDD3" stats.txt
#grep "system.l2.tags.proportionExecTime_VDD1" stats.txt
#grep "system.l2.tags.proportionExecTime_VDD2" stats.txt
#grep "system.l2.tags.proportionExecTime_VDD3" stats.txt
grep "system.l2.tags.staticPower_avg" stats.txt
