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
 * Authors: Erik Hallnor and Mark Gottscho
 */

/**
 * @file
 * Definitions of DPCSLRU tag store.
 */

#include <string>

#include "base/intmath.hh"
#include "debug/Cache.hh"
#include "debug/CacheRepl.hh"
#include "mem/cache/tags/dpcs_lru.hh"
#include "mem/cache/base.hh"
#include "sim/core.hh"

using namespace std;

DPCSLRU::DPCSLRU(const Params *p)
    :BaseTags(p), assoc(p->assoc),
     numSets(p->size / (p->block_size * p->assoc))
{
	if (mode == 1) { //static
		currVDD = 2;
		nextVDD = 2;
	} else if (mode == 2) { //dynamic
		currVDD = 2;
		nextVDD = 2;
	} else {
		fatal("Illegal mode in DPCSLRU constructor!\n");
	}
	
	/**************************************************************/

    // Check parameters
    if (blkSize < 4 || !isPowerOf2(blkSize)) {
        fatal("Block size must be at least 4 and a power of 2");
    }
    if (numSets <= 0 || !isPowerOf2(numSets)) {
        fatal("# of sets must be non-zero and a power of 2");
    }
    if (assoc <= 0) {
        fatal("associativity must be greater than zero");
    }
    if (hitLatency <= 0) {
        fatal("access latency must be greater than zero");
    }

    blkMask = blkSize - 1;
    setShift = floorLog2(blkSize);
    setMask = numSets - 1;
    tagShift = setShift + floorLog2(numSets);
    warmedUp = false;
    /** @todo Make warmup percentage a parameter. */
    warmupBound = numSets * assoc;

    sets = new SetType[numSets];
    blks = new BlkType[numSets * assoc];
    // allocate data storage in one big chunk
    numBlocks = numSets * assoc;
    dataBlks = new uint8_t[numBlocks * blkSize];

    unsigned blkIndex = 0;       // index into blks array
    for (unsigned i = 0; i < numSets; ++i) {
        sets[i].assoc = assoc;

        sets[i].blks = new BlkType*[assoc];

        // link in the data blocks
        for (unsigned j = 0; j < assoc; ++j) {
            // locate next cache block
            BlkType *blk = &blks[blkIndex];
            blk->data = &dataBlks[blkSize*blkIndex];
            ++blkIndex;

            // invalidate new cache block
            blk->invalidate();

            //EGH Fix Me : do we need to initialize blk?

            // Setting the tag to j is just to prevent long chains in the hash
            // table; won't matter because the block is invalid
            blk->tag = j;
            blk->whenReady = 0;
            blk->isTouched = false;
            blk->size = blkSize;
            sets[i].blks[j]=blk;
            blk->set = i;
        }
    }

	//DPCS: Generate fault maps. If there is ever a set at any voltage with all blocks faulty, we regenerate all over again. This is a band-aid, but we should account for the possibility using probability analysis.
	/*if (p->monte_carlo == 1)
		monteCarloGenerateFaultMaps();
	else*/
	regularGenerateFaultMaps();

	inform("Built DPCSLRU cache tags and blocks...\n...mode == %d\n...VDD3 == %d mV\n...VDD2 == %d mV\n...VDD1 == %d mV\n...bitFaultRates_VDD3 == %4.3E\n...bitFaultRates_VDD2 == %4.3E\n...bitFaultRates_VDD1 == %4.3E\n...staticPower_VDD3 == %0.03f\n...staticPower_VDD2 == %0.03f\n...staticPower_VDD1 == %0.03f\n...accessEnergy_VDD3 == %0.03f\n...accessEnergy_VDD2 == %0.03f\n...accessEnergy_VDD1 == %0.03f\n...NumFaultyBlocks_VDD3 == %d\n...NumFaultyBlocks_VDD2 == %d\n...NumFaultyBlocks_VDD1 == %d\n", mode, voltageData[3].vdd, voltageData[2].vdd, voltageData[1].vdd, voltageData[3].ber, voltageData[2].ber, voltageData[1].ber, voltageData[3].staticPower, voltageData[2].staticPower, voltageData[1].staticPower, voltageData[3].accessEnergy, voltageData[2].accessEnergy, voltageData[1].accessEnergy, voltageData[3].nfb, voltageData[2].nfb, voltageData[1].nfb); //DPCS
}

DPCSLRU::~DPCSLRU()
{
    delete [] dataBlks;
    delete [] blks;
    delete [] sets;
}

void DPCSLRU::regularGenerateFaultMaps() //DPCS
{
	int tries = 1;
	bool faultGenerationSuccess;
	BlkType *blk = NULL;
	unsigned blkIndex = 0;
	do {
		inform("Generating fault maps for this cache, try #%d\n", tries);
		faultGenerationSuccess = true;
		blk = NULL;
		blkIndex = 0;
		//gen fault maps
		for (unsigned i = 0; i < numSets; i++) {
			for (unsigned j = 0; j < assoc; j++) { 
				blk = &blks[blkIndex];
				blk->generateFaultMaps(voltageData, 1, NUM_VDD_LEVELS); 
				//set faultMap for the chosen VDD levels
				for (int v = 1; v <= NUM_VDD_LEVELS; v++) {
					if (blk->isFaultyAtVDD[v] == true) {
						blk->setFaultMap(v);
					}
				}
				blkIndex++;
			}
		}

		//inspection
		for (int v = 3; v >= 1; v--) { 
			blkIndex = 0;
			for (unsigned i = 0; i < numSets; i++) {
				int nFaulty = 0;
				for (unsigned j = 0; j < assoc; j++) { //Inspect fault maps for this set
					blk = &blks[blkIndex];
					if (blk->wouldBeFaulty(v)) { //DPCS
						nFaulty++;
					}
					blkIndex++;
				}
				if (nFaulty == assoc) //we have a problem!
					faultGenerationSuccess = false; //need to repeat
			}
		}
		tries++;
	} while (faultGenerationSuccess == false);

	//If we got here, fault maps should be OK. Count faulty blocks for each voltage.
	blkIndex = 0;
	for (unsigned i = 0; i < numSets; ++i) {
		for (unsigned j = 0; j < assoc; ++j) {
			BlkType *blk = &blks[blkIndex];
			if (blk->wouldBeFaulty(currVDD)) //DPCS: set the faulty bit for initial voltage
				blk->setFaulty(true);
			else
				blk->setFaulty(false);
			if (blk->wouldBeFaulty(1))
				voltageData[1].nfb++;
			if (blk->wouldBeFaulty(2))
				voltageData[2].nfb++;
			if (blk->wouldBeFaulty(3))
				voltageData[3].nfb++;
			blkIndex++;
		}
	}
}

/*void DPCSLRU::monteCarloGenerateFaultMaps() //DPCS
{
	BlkType *blk = NULL;
	unsigned blkIndex = 0;
	//gen fault maps
	for (unsigned i = 0; i < numSets; i++) {
		for (unsigned j = 0; j < assoc; j++) { 
			blk = &blks[blkIndex];
			blk->generateFaultMaps(voltageData); 
			blkIndex++;
		}
	}

	//find suitable VDD levels
	VDD[3] = 15; //by default
	VDD[1] = 1; //starting
	int vdd1_index = 1;
	for (vdd1_index = 1; vdd1_index <= 13; vdd1_index++) { //skip last two voltages for VDD1
		int nFaultySets = 0;
		blkIndex = 0;
		for (unsigned i = 0; i < numSets; i++) {
			int nFaulty = 0;
			for (unsigned j = 0; j < assoc; j++) {
				blk = &blks[blkIndex];
				if (blk->isFaultyAtVDD[vdd1_index])
					nFaulty++;
				blkIndex++;
			}
			if (nFaulty == assoc)
				nFaultySets++;
		}
		if (nFaultySets == 0) { //found min-VDD
			VDD[1] = vdd1_index;
			break;
		}
	}

	assert(vdd1_index >= 1 && vdd1_index <= 15);
	int vdd2_index = vdd1_index+1;
	assert(vdd2_index >= 1 && vdd2_index <= 15);
	VDD[2] = vdd2_index; //init
	for (vdd2_index = vdd1_index+1; vdd2_index <= 14; vdd2_index++) { //skip last voltage for VDD2
		int nFaulty = 0;
		blkIndex = 0;
		for (unsigned i = 0; i < numSets; i++) {
			for (unsigned j = 0; j < assoc; j++) {
				blk = &blks[blkIndex];
				if (blk->isFaultyAtVDD[vdd2_index])
					nFaulty++;
				blkIndex++;
			}
		}
		if (nFaulty < 0.01 * numBlocks) { //found VDD2
			VDD[2] = vdd2_index;
			break;
		} 
	}
	
	blkIndex = 0;
	for (unsigned i = 0; i < numSets; i++) {
		for (unsigned j = 0; j < assoc; j++) { 
			blk = &blks[blkIndex];
			//set faultMap for the chosen VDD levels
			for (int v = 1; v <= 3; v++) {
				if (blk->isFaultyAtVDD[VDD[v]] == true) {
					blk->setFaultMap(v);
				}
			}
			blkIndex++;
		}
	}

	//If we got here, fault maps should be OK. Count faulty blocks for each voltage.
	blkIndex = 0;
	for (unsigned i = 0; i < numSets; ++i) {
		for (unsigned j = 0; j < assoc; ++j) {
			BlkType *blk = &blks[blkIndex];
			if (blk->wouldBeFaulty(currVDD)) //DPCS: set the faulty bit for initial voltage
				blk->setFaulty(true);
			else
				blk->setFaulty(false);
			if (blk->wouldBeFaulty(1))
				nfb_1++;
			if (blk->wouldBeFaulty(2))
				nfb_2++;
			if (blk->wouldBeFaulty(3))
				nfb_3++;
			blkIndex++;
		}
	}
}*/

DPCSLRU::BlkType*
DPCSLRU::accessBlock(Addr addr, Cycles &lat, int master_id) //DPCS: look here
{
    Addr tag = extractTag(addr);
    unsigned set = extractSet(addr);
    BlkType *blk = sets[set].findBlk(tag);
    lat = hitLatency;

	assert(currVDD >= 1 && currVDD <= 3);
	if (currVDD == 3)
		accessEnergy_VDD3 += voltageData[3].accessEnergy;
	else if (currVDD == 2)
		accessEnergy_VDD2 += voltageData[2].accessEnergy;
	else 
		accessEnergy_VDD1 += voltageData[1].accessEnergy;

    if (blk != NULL) {
        // move this block to head of the MRU list
        sets[set].moveToHead(blk);
        DPRINTF(CacheRepl, "set %x: moving blk %x to MRU\n",
                set, regenerateBlkAddr(tag, set));
        if (blk->whenReady > curTick()
            && cache->ticksToCycles(blk->whenReady - curTick()) > hitLatency) {
            lat = cache->ticksToCycles(blk->whenReady - curTick());
        }
        blk->refCount += 1;
    }

    return blk;
}


DPCSLRU::BlkType*
DPCSLRU::findBlock(Addr addr) const 
{
    Addr tag = extractTag(addr);
    unsigned set = extractSet(addr);
    BlkType *blk = sets[set].findBlk(tag);
    return blk;
}

DPCSLRU::BlkType*
DPCSLRU::findVictim(Addr addr, PacketList &writebacks) 
{
    unsigned set = extractSet(addr);
    // grab a replacement candidate
	BlkType *blk = NULL;
	for (int i = assoc-1; i >= 0; i--) { //DPCS: we need to potentially check more than LRU in case it is faulty
		blk = sets[set].blks[i];
		if (blk->isFaulty() == false)
			break;
	}
	
	assert(blk != NULL); //DPCS: There should always be at least one non-faulty block in the set since we checked at generation time

    if (blk->isValid()) {
        DPRINTF(CacheRepl, "set %x: selecting blk %x for replacement\n",
                set, regenerateBlkAddr(blk->tag, set));
    }
    return blk;
}

void
DPCSLRU::insertBlock(PacketPtr pkt, BlkType *blk) //DPCS: look here
{
    Addr addr = pkt->getAddr();
    MasterID master_id = pkt->req->masterId();
    if (!blk->isTouched) {
        tagsInUse++;
        blk->isTouched = true;
        if (!warmedUp && tagsInUse.value() >= warmupBound) {
            warmedUp = true;
            warmupCycle = curTick();
        }
    }

    // If we're replacing a block that was previously valid update
    // stats for it. This can't be done in findBlock() because a
    // found block might not actually be replaced there if the
    // coherence protocol says it can't be.
    if (blk->isValid()) {
        replacements[0]++;
        totalRefs += blk->refCount;
        ++sampledRefs;
        blk->refCount = 0;

        // deal with evicted block
        assert(blk->srcMasterId < cache->system->maxMasters());
        occupancies[blk->srcMasterId]--;

        blk->invalidate();
    }

    blk->isTouched = true;
    // Set tag for new block.  Caller is responsible for setting status.
    blk->tag = extractTag(addr);

    // deal with what we are bringing in
    assert(master_id < cache->system->maxMasters());
    occupancies[master_id]++;
    blk->srcMasterId = master_id;

    unsigned set = extractSet(addr);
    sets[set].moveToHead(blk);
}

void
DPCSLRU::invalidate(BlkType *blk) 
{
    assert(blk);
    assert(blk->isValid());
    tagsInUse--;
    assert(blk->srcMasterId < cache->system->maxMasters());
    occupancies[blk->srcMasterId]--;
    blk->srcMasterId = Request::invldMasterId;

    // should be evicted before valid blocks
    unsigned set = blk->set;
    sets[set].moveToTail(blk);
}

void
DPCSLRU::clearLocks()
{
    for (int i = 0; i < numBlocks; i++){
        blks[i].clearLoadLocks();
    }
}

DPCSLRU *
DPCSLRUParams::create()
{
    return new DPCSLRU(this);
}
std::string
DPCSLRU::print() const {
    std::string cache_state;
    for (unsigned i = 0; i < numSets; ++i) {
        // link in the data blocks
        for (unsigned j = 0; j < assoc; ++j) {
            BlkType *blk = sets[i].blks[j];
            if (blk->isValid()) //DPCS: maybe we dont want this check to account for the faulties
                cache_state += csprintf("\tset: %d block: %d %s\n", i, j,
                        blk->print());
        }
    }
    if (cache_state.empty())
        cache_state = "no valid tags\n";
    return cache_state;
}

void
DPCSLRU::cleanupRefs() //DPCS: look here
{
    for (unsigned i = 0; i < numSets*assoc; ++i) {
        if (blks[i].isValid()) {
            totalRefs += blks[i].refCount;
            ++sampledRefs;
        }
    }
}
