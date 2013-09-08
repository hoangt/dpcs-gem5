#!/bin/bash

dir=$1
cd $dir

grep "sim_seconds" stats.txt
grep "host_inst_rate" stats.txt
grep "system.switch_cpus.numCycles" stats.txt
grep "system.switch_cpus.ipc_total" stats.txt
echo "---------------------------------------------"
grep "system.cpu.dcache.overall_miss_rate::total" stats.txt
grep "system.cpu.dcache.tags.numFaultyBlocks_VDD1" stats.txt
grep "system.cpu.dcache.tags.numFaultyBlocks_VDD2" stats.txt
grep "system.cpu.dcache.tags.numFaultyBlocks_VDD3" stats.txt
grep "system.cpu.dcache.tags.cycles_VDD1" stats.txt
grep "system.cpu.dcache.tags.cycles_VDD2" stats.txt
grep "system.cpu.dcache.tags.cycles_VDD3" stats.txt
grep "system.cpu.dcache.tags.transitionsTo_VDD1" stats.txt
grep "system.cpu.dcache.tags.transitionsTo_VDD2" stats.txt
grep "system.cpu.dcache.tags.transitionsTo_VDD3" stats.txt
echo "---------------------------------------------"
grep "system.l2.overall_miss_rate::total" stats.txt
grep "NumFaultyBlocks_VDD" runscript.log
grep "system.l2.tags.cycles_VDD1" stats.txt
grep "system.l2.tags.cycles_VDD2" stats.txt
grep "system.l2.tags.cycles_VDD3" stats.txt
grep "system.l2.tags.transitionsTo_VDD1" stats.txt
grep "system.l2.tags.transitionsTo_VDD2" stats.txt
grep "system.l2.tags.transitionsTo_VDD3" stats.txt
