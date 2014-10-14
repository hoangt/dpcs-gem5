/*
 * Copyright (c) 2013 ARM Limited
 * All rights reserved.
 *
 * The license below extends only to copyright in the software and shall
 * not be construed as granting a license to any other intellectual
 * property including but not limited to intellectual property relating
 * to a hardware implementation of the functionality of the software
 * licensed hereunder.  You may use the software subject to the license
 * terms below provided that you ensure that this notice is replicated
 * unmodified and in its entirety in all distributions of the software,
 * modified or unmodified, in source code or in binary form.
 *
 * Copyright (c) 2003-2005 The Regents of The University of Michigan
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met: redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer;
 * redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution;
 * neither the name of the copyright holders nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Authors: Erik Hallnor
 *          Ron Dreslinski
 */

/**
 * @file
 * Definitions of BaseTags.
 */

#include "cpu/smt.hh" //maxThreadsPerCPU
#include "mem/cache/tags/base.hh"
#include "mem/cache/base.hh"
#include "sim/sim_exit.hh"

#include <string> //DPCS
#include <fstream> //DPCS
#include "mem/cache/tags/pcslevel.hh" //DPCS

using namespace std;

BaseTags::BaseTags(const Params *p)
    : ClockedObject(p), blkSize(p->block_size), size(p->size),
      hitLatency(p->hit_latency),
	 blockReplacementsInFaultySets(0), //DPCS
	 blockReplacementsInFaultySetsRate(0), //DPCS
	 totalBlockReplacements(0) //DPCS
	 //intervalCacheOccupancies(0) //DPCS
{
	/* BEGIN DPCS PARAMS */
	mode = p->mode;
	nextVDD = 3;
	currVDD = 3;
	
	//inform("<DPCS> This cache is using VDD3 = %d mV (nominal), VDD2 = %d mV (>= %0.02f \% non-faulty blocks), VDD1 = %d mV (>= %0.02f \% non-faulty blocks ------- yield-limited? = %d\n", runtimePCSInfo[3].getVDD(), runtimePCSInfo[2].getVDD(), p->vdd2_capacity_level, runtimePCSInfo[1].getVDD(), vdd1_capacity_level, is_yield_limited);
	/* END DPCS PARAMS */
	
	__readRuntimeVDDSelectFile(p->runtime_vdd_select_file); //DPCS: update the runtime VDD data from our file
}

void BaseTags::__readRuntimeVDDSelectFile(std::string filename) {
	inform("<DPCS> [%s] Reading this cache's runtime VDD file: %s\n", name(), filename.c_str());
	ifstream runtimeVDDFile;
	runtimeVDDFile.open(filename.c_str());
	if (runtimeVDDFile.fail())
		fatal("<DPCS> [%s] Failed to open this cache's runtime VDD file: %s\n", name(), filename.c_str());

	//DPCS: Parse the file 
	std::string element;
	inform("<DPCS> [%s] Runtime VDD Index | Voltage (mV) | Total Cache Static Power (mW) | Total Cache Dynamic Energy Per Access (nJ)\n", name());
	for (int i = NUM_RUNTIME_VDD_LEVELS; i > 0; i--) {
		getline(runtimeVDDFile,element,',');
		runtimePCSInfo[i].setVDD(atoi(element.c_str()));
		getline(runtimeVDDFile,element,',');
		runtimePCSInfo[i].setStaticPower(atof(element.c_str()));
		getline(runtimeVDDFile,element);
		runtimePCSInfo[i].setAccessEnergy(atof(element.c_str()));
		runtimePCSInfo[i].setValid(true);
		inform("<DPCS> [%s] %d\t|\t%d\t|\t%0.05f\t|\t%0.05f\n", name(), i, runtimePCSInfo[i].getVDD(), runtimePCSInfo[i].getStaticPower(), runtimePCSInfo[i].getAccessEnergy());
	}

	//Update stats reporting
	/*voltage_VDD1 = runtimePCSInfo[1].getVDD();
	voltage_VDD2 = runtimePCSInfo[2].getVDD();
	voltage_VDD3 = runtimePCSInfo[3].getVDD();
	static_power_VDD1 = runtimePCSInfo[1].getStaticPower();
	static_power_VDD2 = runtimePCSInfo[2].getStaticPower();
	static_power_VDD3 = runtimePCSInfo[3].getStaticPower();
	energy_per_access_VDD1 = runtimePCSInfo[1].getAccessEnergy();
	energy_per_access_VDD2 = runtimePCSInfo[2].getAccessEnergy();
	energy_per_access_VDD3 = runtimePCSInfo[3].getAccessEnergy();
	*/

	inform("<DPCS> [%s] Finished parsing this cache's runtime voltage parameter file\n", name());

	runtimeVDDFile.close();
}


void
BaseTags::setCache(BaseCache *_cache)
{
    cache = _cache;
}

void
BaseTags::regStats()
{
    using namespace Stats;
	double clock_period_sec = (double)frequency(); //DPCS
	double tmp1, tmp2, tmp3 = 0; //DPCS

    replacements
        .init(maxThreadsPerCPU)
        .name(name() + ".replacements")
        .desc("number of replacements")
        .flags(total)
        ;

    tagsInUse
        .name(name() + ".tagsinuse")
        .desc("Cycle average of tags in use")
        ;

    totalRefs
        .name(name() + ".total_refs")
        .desc("Total number of references to valid blocks.")
        ;

    sampledRefs
        .name(name() + ".sampled_refs")
        .desc("Sample count of references to valid blocks.")
        ;

    avgRefs
        .name(name() + ".avg_refs")
        .desc("Average number of references to valid blocks.")
        ;

    avgRefs = totalRefs/sampledRefs;

    warmupCycle
        .name(name() + ".warmup_cycle")
        .desc("Cycle when the warmup percentage was hit.")
        ;

    occupancies
        .init(cache->system->maxMasters())
        .name(name() + ".occ_blocks")
        .desc("Average occupied blocks per requestor")
        .flags(nozero | nonan)
        ;
    for (int i = 0; i < cache->system->maxMasters(); i++) {
        occupancies.subname(i, cache->system->getMasterName(i));
    }

    avgOccs
        .name(name() + ".occ_percent")
        .desc("Average percentage of cache occupancy")
        .flags(nozero | total)
        ;
    for (int i = 0; i < cache->system->maxMasters(); i++) {
        avgOccs.subname(i, cache->system->getMasterName(i));
    }

    avgOccs = occupancies / Stats::constant(numBlocks);

    registerExitCallback(new BaseTagsCallback(this));
	
	numFaultyBlocks_VDD1 //DPCS
        .name(name() + ".numFaultyBlocks_VDD1")
        .desc("Total number of faulty blocks at VDD1 (lowest)")
        ;
	tmp1 = (double)runtimePCSInfo[1].getNFB();
	numFaultyBlocks_VDD1 = constant(tmp1);

	numFaultyBlocks_VDD2 //DPCS
        .name(name() + ".numFaultyBlocks_VDD2")
        .desc("Total number of faulty blocks at VDD2 (mid)")
        ;
	tmp2 = (double)runtimePCSInfo[2].getNFB();
	numFaultyBlocks_VDD2 = constant(tmp2);
	
	numFaultyBlocks_VDD3 //DPCS
        .name(name() + ".numFaultyBlocks_VDD3")
        .desc("Total number of faulty blocks at VDD3 (highest)")
        ;
	tmp3 = (double)runtimePCSInfo[3].getNFB();
	numFaultyBlocks_VDD3 = constant(tmp3);

	blockFaultRate_VDD1 //DPCS
        .name(name() + ".blockFaultRate_VDD1")
        .desc("Proportion of all blocks that are faulty at VDD1")
        ;
	blockFaultRate_VDD1 = numFaultyBlocks_VDD1 / numBlocks;
	
	blockFaultRate_VDD2 //DPCS
        .name(name() + ".blockFaultRate_VDD2")
        .desc("Proportion of all blocks that are faulty at VDD2")
        ;
	blockFaultRate_VDD2 = numFaultyBlocks_VDD2 / numBlocks;
	
	blockFaultRate_VDD3 //DPCS
        .name(name() + ".blockFaultRate_VDD3")
        .desc("Proportion of all blocks that are faulty at VDD3")
        ;
	blockFaultRate_VDD3 = numFaultyBlocks_VDD3 / numBlocks;

	cycles_VDD1 //DPCS
        .name(name() + ".cycles_VDD1")
        .desc("Total number of cycles spent at VDD1")
        ;

	cycles_VDD2 //DPCS
        .name(name() + ".cycles_VDD2")
        .desc("Total number of cycles spent at VDD2")
        ;

	cycles_VDD3 //DPCS
        .name(name() + ".cycles_VDD3")
        .desc("Total number of cycles spent at VDD3")
        ;
	
	transitionsTo_VDD1 //DPCS
        .name(name() + ".transitionsTo_VDD1")
        .desc("Total number of transitions to VDD1")
        ;

	transitionsTo_VDD2 //DPCS
        .name(name() + ".transitionsTo_VDD2")
        .desc("Total number of transitions to VDD2")
        ;

	transitionsTo_VDD3 //DPCS
        .name(name() + ".transitionsTo_VDD3")
        .desc("Total number of transitions to VDD3")
        ;

	avgConsecutiveCycles_VDD1 //DPCS
        .name(name() + ".avgConsecutiveCycles_VDD1")
        .desc("Average number of consecutive cycles at VDD1 after transitioning to it")
        ;
	avgConsecutiveCycles_VDD1 = cycles_VDD1 / transitionsTo_VDD1;

	avgConsecutiveCycles_VDD2 //DPCS
        .name(name() + ".avgConsecutiveCycles_VDD2")
        .desc("Average number of consecutive cycles at VDD2 after transitioning to it")
        ;
	avgConsecutiveCycles_VDD2 = cycles_VDD2 / transitionsTo_VDD2;

	avgConsecutiveCycles_VDD3 //DPCS
        .name(name() + ".avgConsecutiveCycles_VDD3")
        .desc("Average number of consecutive cycles at VDD3 after transitioning to it")
        ;
	avgConsecutiveCycles_VDD3 = cycles_VDD3 / transitionsTo_VDD3;
	
	proportionExecTime_VDD1 //DPCS
        .name(name() + ".proportionExecTime_VDD1")
        .desc("Proportion of total execution time that was spent at VDD1 for this cache")
        ;
	proportionExecTime_VDD1 = cycles_VDD1 / (cycles_VDD1 + cycles_VDD2 + cycles_VDD3);
	
	proportionExecTime_VDD2 //DPCS
        .name(name() + ".proportionExecTime_VDD2")
        .desc("Proportion of total execution time that was spent at VDD2 for this cache")
        ;
	proportionExecTime_VDD2 = cycles_VDD2 / (cycles_VDD1 + cycles_VDD2 + cycles_VDD3);

	proportionExecTime_VDD3 //DPCS
        .name(name() + ".proportionExecTime_VDD3")
        .desc("Proportion of total execution time that was spent at VDD3 for this cache")
        ;
	proportionExecTime_VDD3 = cycles_VDD3 / (cycles_VDD1 + cycles_VDD2 + cycles_VDD3);
	
	numUnchangedNotFaultyTo_VDD1 //DPCS
        .name(name() + ".numUnchangedNotFaultyTo_VDD1")
        .desc("Total number of non-faulty blocks unchanged during DPCS transitions to VDD1")
        ;
	
	numUnchangedNotFaultyTo_VDD2 //DPCS
        .name(name() + ".numUnchangedNotFaultyTo_VDD2")
        .desc("Total number of non-faulty blocks unchanged during DPCS transitions to VDD2")
        ;
	
	numUnchangedNotFaultyTo_VDD3 //DPCS
        .name(name() + ".numUnchangedNotFaultyTo_VDD3")
        .desc("Total number of non-faulty blocks unchanged during DPCS transitions to VDD3")
        ;

	numUnchangedFaultyTo_VDD1 //DPCS
        .name(name() + ".numUnchangedFaultyTo_VDD1")
        .desc("Total number of faulty blocks unchanged during DPCS transitions to VDD1")
        ;
	
	numUnchangedFaultyTo_VDD2 //DPCS
        .name(name() + ".numUnchangedFaultyTo_VDD2")
        .desc("Total number of faulty blocks unchanged during DPCS transitions to VDD2")
        ;
	
	numUnchangedFaultyTo_VDD3 //DPCS
        .name(name() + ".numUnchangedFaultyTo_VDD3")
        .desc("Total number of faulty blocks unchanged during DPCS transitions to VDD3")
        ;
	
	numInvalidateOnlyTo_VDD1 //DPCS
        .name(name() + ".numInvalidateOnlyTo_VDD1")
        .desc("Total number of newly faulty blocks only invalidated during DPCS transitions to VDD1")
        ;
	
	numInvalidateOnlyTo_VDD2 //DPCS
        .name(name() + ".numInvalidateOnlyTo_VDD2")
        .desc("Total number of newly faulty blocks only invalidated during DPCS transitions to VDD2")
        ;
	
	numInvalidateOnlyTo_VDD3 //DPCS
        .name(name() + ".numInvalidateOnlyTo_VDD3")
        .desc("Total number of newly faulty blocks only invalidated during DPCS transitions to VDD3")
        ;

	numFaultyWriteBacksTo_VDD1 //DPCS
        .name(name() + ".numFaultyWriteBacksTo_VDD1")
        .desc("Total number of newly faulty blocks invalidated and written back during DPCS transitions to VDD1")
        ;
	
	numFaultyWriteBacksTo_VDD2 //DPCS
        .name(name() + ".numFaultyWriteBacksTo_VDD2")
        .desc("Total number of newly faulty blocks invalidated and written back during DPCS transitions to VDD2")
        ;
	
	numFaultyWriteBacksTo_VDD3 //DPCS
        .name(name() + ".numFaultyWriteBacksTo_VDD3")
        .desc("Total number of newly faulty blocks invalidated and written back during DPCS transitions to VDD3")
        ;

	numMadeAvailableTo_VDD1 //DPCS
        .name(name() + ".numMadeAvailableTo_VDD1")
        .desc("Total number of newly non-faulty blocks made available during DPCS transitions to VDD1")
        ;
	
	numMadeAvailableTo_VDD2 //DPCS
        .name(name() + ".numMadeAvailableTo_VDD2")
        .desc("Total number of newly non-faulty blocks made available during DPCS transitions to VDD2")
        ;
	
	numMadeAvailableTo_VDD3 //DPCS
        .name(name() + ".numMadeAvailableTo_VDD3")
        .desc("Total number of newly non-faulty blocks made available during DPCS transitions to VDD3")
        ;

	faultyWriteBackRateTo_VDD1 //DPCS
        .name(name() + ".faultyWriteBackRateTo_VDD1")
        .desc("Average number of blocks written back during DPCS transitions to VDD1")
        ;
	faultyWriteBackRateTo_VDD1 = numFaultyWriteBacksTo_VDD1 / transitionsTo_VDD1;

	faultyWriteBackRateTo_VDD2 //DPCS
        .name(name() + ".faultyWriteBackRateTo_VDD2")
        .desc("Average number of blocks written back during DPCS transitions to VDD2")
        ;
	faultyWriteBackRateTo_VDD2 = numFaultyWriteBacksTo_VDD2 / transitionsTo_VDD2;
	
	faultyWriteBackRateTo_VDD3 //DPCS
        .name(name() + ".faultyWriteBackRateTo_VDD3")
        .desc("Average number of blocks written back during DPCS transitions to VDD3")
        ;
	faultyWriteBackRateTo_VDD3 = numFaultyWriteBacksTo_VDD3 / transitionsTo_VDD3;
	
	blockReplacementsInFaultySets_VDD1 //DPCS
        .name(name() + ".blockReplacementsInFaultySets_VDD1")
        .desc("Total number of block replacements that occurred in sets with at least one faulty block at VDD1")
        ;
	
	blockReplacementsInFaultySets_VDD2 //DPCS
        .name(name() + ".blockReplacementsInFaultySets_VDD2")
        .desc("Total number of block replacements that occurred in sets with at least one faulty block at VDD2")
        ;
	
	blockReplacementsInFaultySets_VDD3 //DPCS
        .name(name() + ".blockReplacementsInFaultySets_VDD3")
        .desc("Total number of block replacements that occurred in sets with at least one faulty block at VDD3")
        ;
	
	blockReplacements_VDD1 //DPCS
        .name(name() + ".blockReplacements_VDD1")
        .desc("Total number of block replacements that occurred at VDD1")
        ;
	
	blockReplacements_VDD2 //DPCS
        .name(name() + ".blockReplacements_VDD2")
        .desc("Total number of block replacements that occurred at VDD2")
        ;
	
	blockReplacements_VDD3 //DPCS
        .name(name() + ".blockReplacements_VDD3")
        .desc("Total number of block replacements that occurred at VDD3")
        ;

	blockReplacementsInFaultySetsRate_VDD1 //DPCS
		.name(name() + ".blockReplacementsInFaultySetsRate_VDD1")
		.desc("Fraction of block replacements that occurred in faulty sets at VDD1")
		;
	blockReplacementsInFaultySetsRate_VDD1 = blockReplacementsInFaultySets_VDD1 / blockReplacements_VDD1;

	blockReplacementsInFaultySetsRate_VDD2 //DPCS
		.name(name() + ".blockReplacementsInFaultySetsRate_VDD2")
		.desc("Fraction of block replacements that occurred in faulty sets at VDD2")
		;
	blockReplacementsInFaultySetsRate_VDD2 = blockReplacementsInFaultySets_VDD2 / blockReplacements_VDD2;

	blockReplacementsInFaultySetsRate_VDD3 //DPCS
		.name(name() + ".blockReplacementsInFaultySetsRate_VDD3")
		.desc("Fraction of block replacements that occurred in faulty sets at VDD3")
		;
	blockReplacementsInFaultySetsRate_VDD3 = blockReplacementsInFaultySets_VDD3 / blockReplacements_VDD3;

	accessEnergy_VDD1 //DPCS
        .name(name() + ".accessEnergy_VDD1")
        .desc("Total dynamic energy dissipated at VDD1 in nJ")
        ;
	
	accessEnergy_VDD2 //DPCS
        .name(name() + ".accessEnergy_VDD2")
        .desc("Total dynamic energy dissipated at VDD2 in nJ")
        ;
	
	accessEnergy_VDD3 //DPCS
        .name(name() + ".accessEnergy_VDD3")
        .desc("Total dynamic energy dissipated at VDD3 in nJ")
        ;
	
	accessEnergy_tot //DPCS
		.name(name() + ".accessEnergy_tot")
		.desc("Total dynamic energy dissipated in nJ")
		;
	accessEnergy_tot = accessEnergy_VDD3 + accessEnergy_VDD2 + accessEnergy_VDD1;
	
	accessPower_avg //DPCS
		.name(name() + ".accessPower_avg")
		.desc("Average dynamic energy dissipated in nW")
		;
	accessPower_avg = accessEnergy_tot / ((cycles_VDD3 + cycles_VDD2 + cycles_VDD1) * constant(clock_period_sec));

	staticEnergy_VDD1 //DPCS
        .name(name() + ".staticEnergy_VDD1")
        .desc("Total static energy dissipated at VDD1 in mJ")
        ;
	tmp1 = runtimePCSInfo[1].getStaticPower();
	staticEnergy_VDD1 = cycles_VDD1 * constant(clock_period_sec) * constant(tmp1); //DPCS

	staticEnergy_VDD2 //DPCS
        .name(name() + ".staticEnergy_VDD2")
        .desc("Total static energy dissipated at VDD2 in mJ")
        ;
	tmp2 = runtimePCSInfo[2].getStaticPower();
	staticEnergy_VDD2 = cycles_VDD2 * constant(clock_period_sec) * constant(tmp2); //DPCS
	
	staticEnergy_VDD3 //DPCS
        .name(name() + ".staticEnergy_VDD3")
        .desc("Total static energy dissipated at VDD3 in mJ")
        ;
	tmp3 = runtimePCSInfo[3].getStaticPower();
	staticEnergy_VDD3 = cycles_VDD3 * constant(clock_period_sec) * constant(tmp3); //DPCS
	
	staticEnergy_tot //DPCS
		.name(name() + ".staticEnergy_tot")
		.desc("Total static energy dissipated in mJ")
		;
	staticEnergy_tot = staticEnergy_VDD3 + staticEnergy_VDD2 + staticEnergy_VDD1;

	staticPower_avg
		.name(name() + ".staticPower_avg")
		.desc("Average static power of this cache over the entire execution in mW")
		;
	tmp1 = runtimePCSInfo[1].getStaticPower();
	tmp2 = runtimePCSInfo[2].getStaticPower();
	tmp3 = runtimePCSInfo[3].getStaticPower();
	staticPower_avg = proportionExecTime_VDD1 * constant(tmp1) + proportionExecTime_VDD2 * constant(tmp2) + proportionExecTime_VDD3 * constant(tmp3); //DPCS

	voltage_VDD1 //DPCS
		.name(name() + ".voltage_VDD1")
		.desc("Voltage level in mV for runtime VDD1 level")
		;
	tmp1 = (double)runtimePCSInfo[1].getVDD();
	voltage_VDD1 = constant(tmp1);
	
	voltage_VDD2 //DPCS
		.name(name() + ".voltage_VDD2")
		.desc("Voltage level in mV for runtime VDD2 level")
		;
	tmp2 = (double)runtimePCSInfo[2].getVDD();
	voltage_VDD2 = constant(tmp2);
	
	voltage_VDD3 //DPCS
		.name(name() + ".voltage_VDD3")
		.desc("Voltage level in mV for runtime VDD3 level")
		;
	tmp3 = (double)runtimePCSInfo[3].getVDD();
	voltage_VDD3 = constant(tmp3);
	
	static_power_VDD1 //DPCS
		.name(name() + ".static_power_VDD1")
		.desc("Static power in mW for runtime VDD1 level")
		;
	tmp1 = runtimePCSInfo[1].getStaticPower();
	static_power_VDD1 = constant(tmp1);
	
	static_power_VDD2 //DPCS
		.name(name() + ".static_power_VDD2")
		.desc("Static power in mW for runtime VDD2 level")
		;
	tmp2 = runtimePCSInfo[2].getStaticPower();
	static_power_VDD2 = constant(tmp2);
	
	static_power_VDD3 //DPCS
		.name(name() + ".static_power_VDD3")
		.desc("Static power in mW for runtime VDD3 level")
		;
	tmp3 = runtimePCSInfo[3].getStaticPower();
	static_power_VDD3 = constant(tmp3);

	energy_per_access_VDD1 //DPCS
		.name(name() + ".energy_per_access_VDD1")
		.desc("Dynamic energy per access in nJ for runtime VDD1 level")
		;
	tmp1 = runtimePCSInfo[1].getAccessEnergy();
	energy_per_access_VDD1 = constant(tmp1);

	energy_per_access_VDD2 //DPCS
		.name(name() + ".energy_per_access_VDD2")
		.desc("Dynamic energy per access in nJ for runtime VDD2 level")
		;
	tmp2 = runtimePCSInfo[2].getAccessEnergy();
	energy_per_access_VDD2 = constant(tmp2);

	energy_per_access_VDD3 //DPCS
		.name(name() + ".energy_per_access_VDD3")
		.desc("Dynamic energy per access in nJ for runtime VDD3 level")
		;
	tmp3 = runtimePCSInfo[3].getAccessEnergy();
	energy_per_access_VDD3 = constant(tmp3);
}
