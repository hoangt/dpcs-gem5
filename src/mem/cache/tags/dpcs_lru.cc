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
	currVDD = 3;
	nextVDD = 3;
	inform("Constructing DPCSLRU cache tags and blocks...\n...VDD1 == %d mV\n...VDD2 == %d mV\n...VDD3 == %d mV\n...bitFaultRates1 == %lu\n...bitFaultRates2 == %lu\n...bitFaultRates3 == %lu\n...initial VDD%d (%d mV)", VDD[1], VDD[2], VDD[3], bitFaultRates[1], bitFaultRates[2], bitFaultRates[3], currVDD, VDD[currVDD]); //DPCS
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
	int nfb_1 = 0;
	int nfb_2 = 0;
	int nfb_3 = 0;
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

			//DPCS: Set the fault rates for this block
			blk->bitFaultRates[0] = 0;
			blk->bitFaultRates[1] = bitFaultRates[1];
			blk->bitFaultRates[2] = bitFaultRates[2];
			blk->bitFaultRates[3] = bitFaultRates[3];
        }
    }

	//DPCS: Generate fault maps. If there is ever a set at any voltage with all blocks faulty, we regenerate all over again. This is a band-aid, but we should account for the possibility using probability analysis.
	int tries = 1;
	bool faultGenerationSuccess;
	do {
		inform("Generating fault maps for this cache, try #%d\n", tries);
		faultGenerationSuccess = true;
		BlkType *blk = NULL;
		blkIndex = 0;
		//gen fault maps
		for (unsigned i = 0; i < numSets; i++) {
			for (unsigned j = 0; j < assoc; j++) { 
				blk = &blks[blkIndex];
				blk->generateFaultMaps(); 
				blkIndex++;
			}
		}
		//inspection
		for (unsigned i = 0; i < numSets; i++) {
			for (int v = 3; v >= 1; v--) { 
				int nFaulty = 0;
				blkIndex = i*assoc;
				for (unsigned j = 0; j < assoc; j++) { //Inspect fault maps for this set
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
				nfb_1++;
			if (blk->wouldBeFaulty(2))
				nfb_2++;
			if (blk->wouldBeFaulty(3))
				nfb_3++;
			blkIndex++;
		}
	}

	inform("NumFaultyBlocks_VDD1 = %d\nNumFaultyBlocks_VDD2 = %d\nNumFaultyBlocks_VDD3 = %d\n", nfb_1, nfb_2, nfb_3);
}

DPCSLRU::~DPCSLRU()
{
    delete [] dataBlks;
    delete [] blks;
    delete [] sets;
}

DPCSLRU::BlkType*
DPCSLRU::accessBlock(Addr addr, Cycles &lat, int master_id) //DPCS: look here
{
    Addr tag = extractTag(addr);
    unsigned set = extractSet(addr);
    BlkType *blk = sets[set].findBlk(tag);
    lat = hitLatency;

	assert(currVDD >= 1 && currVDD <= 3);
	if (currVDD == 3)
		accessEnergy_VDD3 += accessEnergy[3];
	else if (currVDD == 2)
		accessEnergy_VDD2 += accessEnergy[2];
	else 
		accessEnergy_VDD1 += accessEnergy[1];

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
