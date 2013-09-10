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

using namespace std;

BaseTags::BaseTags(const Params *p)
    : ClockedObject(p), blkSize(p->block_size), size(p->size),
      hitLatency(p->hit_latency)
{
	/* BEGIN DPCS PARAMS */
	bitFaultRates[0] = 0;
	bitFaultRates[1] = p->bit_faultrate1;
	bitFaultRates[2] = p->bit_faultrate2;
	bitFaultRates[3] = p->bit_faultrate3;
	VDD[0] = 0;
	VDD[1] = p->vdd1;
	VDD[2] = p->vdd2;
	VDD[3] = p->vdd3;
	accessEnergy[0] = 0;
	accessEnergy[1] = p->accessEnergy1;
	accessEnergy[2] = p->accessEnergy2;
	accessEnergy[3] = p->accessEnergy3;
	/* END DPCS PARAMS */
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
        .desc("number of faulty blocks in the cache at VDD1 (lowest)")
        ;

	numFaultyBlocks_VDD2 //DPCS
        .name(name() + ".numFaultyBlocks_VDD2")
        .desc("number of faulty blocks in the cache at VDD2 (mid)")
        ;
	
	numFaultyBlocks_VDD3 //DPCS
        .name(name() + ".numFaultyBlocks_VDD3")
        .desc("number of faulty blocks in the cache at VDD3 (highest)")
        ;

	blockFaultRate_VDD1 //DPCS
        .name(name() + ".blockFaultRate_VDD1")
        .desc("Proportion of faulty blocks in the cache at VDD1")
        ;
	blockFaultRate_VDD1 = numFaultyBlocks_VDD1 / numBlocks;
	
	blockFaultRate_VDD2 //DPCS
        .name(name() + ".blockFaultRate_VDD2")
        .desc("Proportion of faulty blocks in the cache at VDD2")
        ;
	blockFaultRate_VDD2 = numFaultyBlocks_VDD2 / numBlocks;
	
	blockFaultRate_VDD3 //DPCS
        .name(name() + ".blockFaultRate_VDD3")
        .desc("Proportion of faulty blocks in the cache at VDD3")
        ;
	blockFaultRate_VDD3 = numFaultyBlocks_VDD3 / numBlocks;

	cycles_VDD1 //DPCS
        .name(name() + ".cycles_VDD1")
        .desc("Total number of cycles spent on VDD1")
        ;

	cycles_VDD2 //DPCS
        .name(name() + ".cycles_VDD2")
        .desc("Total number of cycles spent on VDD2")
        ;

	cycles_VDD3 //DPCS
        .name(name() + ".cycles_VDD3")
        .desc("Total number of cycles spent on VDD3")
        ;
	
	accessEnergy_VDD3 //DPCS
        .name(name() + ".accessEnergy_VDD3")
        .desc("Total dynamic energy dissipated at VDD3 in nJ")
        ;
	
	accessEnergy_VDD2 //DPCS
        .name(name() + ".accessEnergy_VDD2")
        .desc("Total dynamic energy dissipated at VDD2 in nJ")
        ;
	
	accessEnergy_VDD1 //DPCS
        .name(name() + ".accessEnergy_VDD1")
        .desc("Total dynamic energy dissipated at VDD1 in nJ")
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
        .desc("Average number of consecutive cycles spent at VDD1")
        ;
	avgConsecutiveCycles_VDD1 = cycles_VDD1 / transitionsTo_VDD1;

	avgConsecutiveCycles_VDD2 //DPCS
        .name(name() + ".avgConsecutiveCycles_VDD2")
        .desc("Average number of consecutive cycles spent at VDD2")
        ;
	avgConsecutiveCycles_VDD2 = cycles_VDD2 / transitionsTo_VDD2;

	avgConsecutiveCycles_VDD3 //DPCS
        .name(name() + ".avgConsecutiveCycles_VDD3")
        .desc("Average number of consecutive cycles spent at VDD3")
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
	
	numUnchangedFaultyTo_VDD1 //DPCS
        .name(name() + ".numUnchangedFaultyTo_VDD1")
        .desc("Total number of unchanged (faulty) blocks during DPCS transition to VDD1")
        ;
	
	numUnchangedFaultyTo_VDD2 //DPCS
        .name(name() + ".numUnchangedFaultyTo_VDD2")
        .desc("Total number of unchanged (faulty) blocks during DPCS transition to VDD2")
        ;
	
	numUnchangedFaultyTo_VDD3 //DPCS
        .name(name() + ".numUnchangedFaultyTo_VDD3")
        .desc("Total number of unchanged (faulty) blocks during DPCS transition to VDD3")
        ;

	numFaultyWriteBacksTo_VDD1 //DPCS
        .name(name() + ".numFaultyWriteBacksTo_VDD1")
        .desc("Total number of faulty writebacks during DPCS transition to VDD1")
        ;
	
	numFaultyWriteBacksTo_VDD2 //DPCS
        .name(name() + ".numFaultyWriteBacksTo_VDD2")
        .desc("Total number of faulty writebacks during DPCS transition to VDD2")
        ;
	
	numFaultyWriteBacksTo_VDD3 //DPCS
        .name(name() + ".numFaultyWriteBacksTo_VDD3")
        .desc("Total number of faulty writebacks during DPCS transition to VDD3")
        ;
	
	numInvalidateOnlyTo_VDD1 //DPCS
        .name(name() + ".numInvalidateOnlyTo_VDD1")
        .desc("Total number of blocks only invalidated during DPCS transition to VDD1")
        ;
	
	numInvalidateOnlyTo_VDD2 //DPCS
        .name(name() + ".numInvalidateOnlyTo_VDD2")
        .desc("Total number of blocks only invalidated during DPCS transition to VDD2")
        ;
	
	numInvalidateOnlyTo_VDD3 //DPCS
        .name(name() + ".numInvalidateOnlyTo_VDD3")
        .desc("Total number of blocks only invalidated during DPCS transition to VDD3")
        ;

	numMadeAvailableTo_VDD1 //DPCS
        .name(name() + ".numMadeAvailableTo_VDD1")
        .desc("Total number of blocks made available (faulty to non-faulty) during DPCS transition to VDD1")
        ;
	
	numMadeAvailableTo_VDD2 //DPCS
        .name(name() + ".numMadeAvailableTo_VDD2")
        .desc("Total number of blocks made available (faulty to non-faulty) during DPCS transition to VDD2")
        ;
	
	numMadeAvailableTo_VDD3 //DPCS
        .name(name() + ".numMadeAvailableTo_VDD3")
        .desc("Total number of blocks made available (faulty to non-faulty) during DPCS transition to VDD3")
        ;

	numUnchangedNotFaultyTo_VDD1 //DPCS
        .name(name() + ".numUnchangedNotFaultyTo_VDD1")
        .desc("Total number of blocks unchanged (not faulty) during DPCS transition to VDD1")
        ;
	
	numUnchangedNotFaultyTo_VDD2 //DPCS
        .name(name() + ".numUnchangedNotFaultyTo_VDD2")
        .desc("Total number of blocks unchanged (not faulty) during DPCS transition to VDD2")
        ;
	
	numUnchangedNotFaultyTo_VDD3 //DPCS
        .name(name() + ".numUnchangedNotFaultyTo_VDD3")
        .desc("Total number of blocks unchanged (not faulty) during DPCS transition to VDD3")
        ;

	faultyWriteBackRateTo_VDD1 //DPCS
        .name(name() + ".faultyWriteBackRateTo_VDD1")
        .desc("Average number of writebacks caused by faulty blocks when changing to VDD1")
        ;
	faultyWriteBackRateTo_VDD1 = numFaultyWriteBacksTo_VDD1 / transitionsTo_VDD1;

	faultyWriteBackRateTo_VDD2 //DPCS
        .name(name() + ".faultyWriteBackRateTo_VDD2")
        .desc("Average number of writebacks caused by faulty blocks when changing to VDD2")
        ;
	faultyWriteBackRateTo_VDD2 = numFaultyWriteBacksTo_VDD2 / transitionsTo_VDD2;
	
	faultyWriteBackRateTo_VDD3 //DPCS
        .name(name() + ".faultyWriteBackRateTo_VDD3")
        .desc("Average number of writebacks caused by faulty blocks when changing to VDD3")
        ;
	faultyWriteBackRateTo_VDD3 = numFaultyWriteBacksTo_VDD3 / transitionsTo_VDD3;
}
