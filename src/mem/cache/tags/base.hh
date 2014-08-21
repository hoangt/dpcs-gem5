/*
 * Copyright (c) 2012-2013 ARM Limited
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
 * Declaration of a common base class for cache tagstore objects.
 */

#ifndef __BASE_TAGS_HH__
#define __BASE_TAGS_HH__

#include <string>

#include "base/callback.hh"
#include "base/statistics.hh"
#include "params/BaseTags.hh"
#include "sim/clocked_object.hh"

#include "mem/cache/tags/pcslevel.hh" //DPCS

class BaseCache;

/**
 * A common base class of Cache tagstore objects.
 */
class BaseTags : public ClockedObject
{
  protected:
    /** The block size of the cache. */
    const unsigned blkSize;
    /** The size of the cache. */
    const unsigned size;
    /** The hit latency of the cache. */
    const Cycles hitLatency;

    /** Pointer to the parent cache. */
    BaseCache *cache;

    /**
     * The number of tags that need to be touched to meet the warmup
     * percentage.
     */
    int warmupBound;
    /** Marked true when the cache is warmed up. */
    bool warmedUp;

    /** the number of blocks in the cache */
    unsigned numBlocks;

	/* DPCS-specific variables */

	int mode; //DPCS: regular vanilla mode, SPCS, or DPCS
	int currVDD; //DPCS: current enumerated VDD level
	int nextVDD; //DPCS: next enumerated VDD level to change to. Used to determine what block faulty status will become when we transition

	PCSLevel runtimePCSInfo[NUM_RUNTIME_VDD_LEVELS+1]; //DPCS: Just the PCS levels of interest for cache runtime, plus one dummy at index [0].

  public:
	unsigned long blockReplacementsInFaultySets; //DPCS: total number of block replacements in faulty sets that have occurred, compared to all block replacements. This is public so that the cache can manipulate this easily for DPCS bookkeeping
	unsigned long blockReplacementsInFaultySetsRate; //DPCS: rate of block replacements in faulty sets that have occurred, compared to all block replacements. This is public so that the cache can manipulate this easily for DPCS bookkeeping
	unsigned long totalBlockReplacements; //DPCS: total number of block replacements that have occurred. This is public so that the cache can manipulate this easily for DPCS bookkeeping.

    // Statistics
    /**
     * @addtogroup CacheStatistics
     * @{
     */

    /** Number of replacements of valid blocks per thread. */
    Stats::Vector replacements;

    /** Per cycle average of the number of tags that hold valid data. */
    Stats::Average tagsInUse;

    /** The total number of references to a block before it is replaced. */
    Stats::Scalar totalRefs;

    /**
     * The number of reference counts sampled. This is different from
     * replacements because we sample all the valid blocks when the simulator
     * exits.
     */
    Stats::Scalar sampledRefs;

    /**
     * Average number of references to a block before is was replaced.
     * @todo This should change to an average stat once we have them.
     */
    Stats::Formula avgRefs;

    /** The cycle that the warmup percentage was hit. */
    Stats::Scalar warmupCycle;

    /** Average occupancy of each requestor using the cache */
    Stats::AverageVector occupancies;

    /** Average occ % of each requestor using the cache */
    Stats::Formula avgOccs;

	/* DPCS-SPECIFIC STATISTICS */
	
	/** Total number of faulty blocks at each voltage. */
	Stats::Scalar numFaultyBlocks_VDD1; //DPCS
	Stats::Scalar numFaultyBlocks_VDD2; //DPCS
	Stats::Scalar numFaultyBlocks_VDD3; //DPCS
	
	/** Proportion of all blocks that are faulty for each voltage */
	Stats::Formula blockFaultRate_VDD1; //DPCS
	Stats::Formula blockFaultRate_VDD2; //DPCS
	Stats::Formula blockFaultRate_VDD3; //DPCS

	/** Total number of cycles spent at each VDD */
	Stats::Scalar cycles_VDD1; //DPCS
	Stats::Scalar cycles_VDD2; //DPCS
	Stats::Scalar cycles_VDD3; //DPCS

	/** Total number of transitions to each voltage */
	Stats::Scalar transitionsTo_VDD1; //DPCS
	Stats::Scalar transitionsTo_VDD2; //DPCS
	Stats::Scalar transitionsTo_VDD3; //DPCS

	/** Average number of cycles at each voltage after transitioning to it */
	Stats::Formula avgConsecutiveCycles_VDD1; //DPCS
	Stats::Formula avgConsecutiveCycles_VDD2; //DPCS
	Stats::Formula avgConsecutiveCycles_VDD3; //DPCS

	/** Proportion of total execution time that was spent at each VDD for this cache */
	Stats::Formula proportionExecTime_VDD1; //DPCS
	Stats::Formula proportionExecTime_VDD2; //DPCS
	Stats::Formula proportionExecTime_VDD3; //DPCS

	/** Total number of non-faulty blocks unchanged during all DPCS transitions */
	Stats::Scalar numUnchangedNotFaultyTo_VDD1; //DPCS
	Stats::Scalar numUnchangedNotFaultyTo_VDD2; //DPCS
	Stats::Scalar numUnchangedNotFaultyTo_VDD3; //DPCS

	/** Total number of faulty blocks unchanged during all DPCS transitions */
	Stats::Scalar numUnchangedFaultyTo_VDD1; //DPCS
	Stats::Scalar numUnchangedFaultyTo_VDD2; //DPCS
	Stats::Scalar numUnchangedFaultyTo_VDD3; //DPCS

	/** Total number of newly faulty blocks only invalidated during all DPCS transitions */
	Stats::Scalar numInvalidateOnlyTo_VDD1; //DPCS
	Stats::Scalar numInvalidateOnlyTo_VDD2; //DPCS
	Stats::Scalar numInvalidateOnlyTo_VDD3; //DPCS

	/** Total number of newly faulty blocks invalidated and written back during all DPCS transitions */
	Stats::Scalar numFaultyWriteBacksTo_VDD1; //DPCS
	Stats::Scalar numFaultyWriteBacksTo_VDD2; //DPCS
	Stats::Scalar numFaultyWriteBacksTo_VDD3; //DPCS

	/** Total number of newly non-faulty blocks made available during all DPCS transitions */
	Stats::Scalar numMadeAvailableTo_VDD1; //DPCS
	Stats::Scalar numMadeAvailableTo_VDD2; //DPCS
	Stats::Scalar numMadeAvailableTo_VDD3; //DPCS

	/** Average number of blocks written back on VDD transitions */
	Stats::Formula faultyWriteBackRateTo_VDD1; //DPCS
	Stats::Formula faultyWriteBackRateTo_VDD2; //DPCS
	Stats::Formula faultyWriteBackRateTo_VDD3; //DPCS
	
	/** Total number of block replacements that occurred in sets with at least one faulty block */
	Stats::Scalar blockReplacementsInFaultySets_VDD1; //DPCS
	Stats::Scalar blockReplacementsInFaultySets_VDD2; //DPCS
	Stats::Scalar blockReplacementsInFaultySets_VDD3; //DPCS

	/** Total number of block replacements that occurred */
	Stats::Scalar blockReplacements_VDD1; //DPCS
	Stats::Scalar blockReplacements_VDD2; //DPCS
	Stats::Scalar blockReplacements_VDD3; //DPCS

	/** Fraction of block replacements that occurred in faulty sets */
	Stats::Formula blockReplacementsInFaultySetsRate_VDD1; //DPCS
	Stats::Formula blockReplacementsInFaultySetsRate_VDD2; //DPCS
	Stats::Formula blockReplacementsInFaultySetsRate_VDD3; //DPCS

	/** Total dynamic access energy dissipated at each voltage */
	Stats::Scalar accessEnergy_VDD1; //DPCS
	Stats::Scalar accessEnergy_VDD2; //DPCS
	Stats::Scalar accessEnergy_VDD3; //DPCS
	Stats::Formula accessEnergy_tot; //DPCS

	/** Average dynamic energy dissipated in nW */
	Stats::Formula accessPower_avg; //DPCS

	/** Total static energy dissipated at each voltage */
	Stats::Formula staticEnergy_VDD1; //DPCS
	Stats::Formula staticEnergy_VDD2; //DPCS
	Stats::Formula staticEnergy_VDD3; //DPCS
	Stats::Formula staticEnergy_tot; //DPCS

	/** Average static power dissipated in the cache at all voltages */
	Stats::Formula staticPower_avg; //DPCS

	/** Voltage levels in mV for each runtime voltage level */
	Stats::Formula voltage_VDD1; //DPCS
	Stats::Formula voltage_VDD2; //DPCS
	Stats::Formula voltage_VDD3; //DPCS

	/** Static power in mW for each runtime voltage level */
	Stats::Formula static_power_VDD1; //DPCS
	Stats::Formula static_power_VDD2; //DPCS
	Stats::Formula static_power_VDD3; //DPCS

	/** Dynamic energy per access in nJ for each runtime voltage level */
	Stats::Formula energy_per_access_VDD1; //DPCS
	Stats::Formula energy_per_access_VDD2; //DPCS
	Stats::Formula energy_per_access_VDD3; //DPCS

    /**
     * @}
     */

    typedef BaseTagsParams Params;
    BaseTags(const Params *p);

private: //DPCS
	void __readRuntimeVDDSelectFile(std::string filename); //DPCS: parse the VDD selection file, and set the runtime VDD data accordingly
public: //DPCS

    /**
     * Destructor.
     */
    virtual ~BaseTags() {}

    /**
     * Set the parent cache back pointer.
     * @param _cache Pointer to parent cache.
     */
    void setCache(BaseCache *_cache);

    /**
     * Register local statistics.
     */
    void regStats();

    /**
     * Average in the reference count for valid blocks when the simulation
     * exits.
     */
    virtual void cleanupRefs() {}

    /**
     *iterated through all blocks and clear all locks
     *Needed to clear all lock tracking at once
     */
    virtual void clearLocks() {}

    /**
     * Print all tags used
     */
    virtual std::string print() const = 0;

	/* DPCS-specific methods */

	int getNextVDD() const //DPCS
	{
		return nextVDD;
	}
	
	int getCurrVDD() const //DPCS
	{
		return currVDD;
	}

	unsigned getNumBlocks() const //DPCS
	{
		return numBlocks;
	}

	void setNextVDD(int VDD) //DPCS
	{
		nextVDD = VDD;
	}
	
	void setCurrVDD(int VDD) //DPCS
	{
		currVDD = VDD;
	}

};

class BaseTagsCallback : public Callback
{
    BaseTags *tags;
  public:
    BaseTagsCallback(BaseTags *t) : tags(t) {}
    virtual void process() { tags->cleanupRefs(); };
};

#endif //__BASE_TAGS_HH__
