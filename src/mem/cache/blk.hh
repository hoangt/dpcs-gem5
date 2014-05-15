/*
 * Copyright (c) 2012 ARM Limited
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
 *          Andreas Sandberg
 */

/** @file
 * Definitions of a simple cache block class.
 */

#ifndef __CACHE_BLK_HH__
#define __CACHE_BLK_HH__

#include <list>
#include <ctime> //DPCS: for seeding random

#include "base/printable.hh"
#include "mem/packet.hh"
#include "mem/request.hh"
#include "sim/core.hh"          // for Tick
#include "base/random.hh" //DPCS: for random number gen
#include "mem/cache/tags/pcslevel.hh" //DPCS TODO remove me
#include "mem/cache/tags/base.hh" //DPCS TODO remove me

/**
 * Cache block status bit assignments
 */
enum CacheBlkStatusBits { //DPCS: I changed these to be 12-bit
    /** valid, readable */
    BlkValid =          0x001,
    /** write permission */
    BlkWritable =       0x002,
    /** read permission (yes, block can be valid but not readable) */
    BlkReadable =       0x004,
    /** dirty (modified) */
    BlkDirty =          0x008,
    /** block was referenced */
    BlkReferenced =     0x010,
    /** block was a hardware prefetch yet unaccessed*/
    BlkHWPrefetched =   0x020,
	/** Bit 0 of this block's fault map. This is NOT cleared on invalidate, it persists as read-only throughout execution. */	
	FM0 =				0x040, //DPCS
	/** Bit 1 of this block's fault map. This is NOT cleared on invalidate, it persists as read-only throughout execution. */	
	FM1 =				0x080, //DPCS
	/** Flag indicating if this block is faulty at the current VDD. If this is 1, the block MUST be invalid. This is NOT cleared on invalidate, it persists throughout execution. It is only updated when cache VDD is scaled by PCS mechanism. */	
	BlkFaulty = 		0x100 //DPCS
};

/**
 * A Basic Cache block.
 * Contains the tag, status, and a pointer to data.
 */
class CacheBlk
{
  public:
  	#define FMMask 0x0C0 //DPCS, extract FM1/FM0 bits from a block State
	#define MAX_BLOCK_SIZE 256*8 //DPCS, max block size in bits

    /** The address space ID of this block. */
    int asid;
    /** Data block tag value. */
    Addr tag;
    /**
     * Contains a copy of the data in this block for easy access. This is used
     * for efficient execution when the data could be actually stored in
     * another format (COW, compressed, sub-blocked, etc). In all cases the
     * data stored here should be kept consistant with the actual data
     * referenced by this block.
     */
    uint8_t *data;

    /** the number of bytes stored in this block. */
    int size;

    /** block state: OR of CacheBlkStatusBit */
    typedef unsigned State;

    /** The current status of this block. @sa CacheBlockStatusBits */
    State status;

    /** Which curTick() will this block be accessable */
    Tick whenReady;

    /**
     * The set this block belongs to.
     * @todo Move this into subclasses when we fix CacheTags to use them.
     */
    int set;

    /** whether this block has been touched */
    bool isTouched;

    /** Number of references to this block since it was brought in. */
    int refCount;

    /** holds the source requestor ID for this block. */
    int srcMasterId;

	bool isFaultyAtVDD[NUM_RUNTIME_VDD_LEVELS+1]; //DPCS: index0 must not be used

  protected:
    /**
     * Represents that the indicated thread context has a "lock" on
     * the block, in the LL/SC sense.
     */
    class Lock {
      public:
        int contextId;     // locking context
        Addr lowAddr;      // low address of lock range
        Addr highAddr;     // high address of lock range

        // check for matching execution context
        bool matchesContext(Request *req)
        {
            Addr req_low = req->getPaddr();
            Addr req_high = req_low + req->getSize() -1;
            return (contextId == req->contextId()) &&
                   (req_low >= lowAddr) && (req_high <= highAddr);
        }

        bool overlapping(Request *req)
        {
            Addr req_low = req->getPaddr();
            Addr req_high = req_low + req->getSize() - 1;

            return (req_low <= highAddr) && (req_high >= lowAddr);
        }

        Lock(Request *req)
            : contextId(req->contextId()),
              lowAddr(req->getPaddr()),
              highAddr(lowAddr + req->getSize() - 1)
        {
        }
    };


    /** List of thread contexts that have performed a load-locked (LL)
     * on the block since the last store. */
    std::list<Lock> lockList;
  
  private:
	static Random randomGenerator; //seed with system time DPCS TODO remove me

  
  public:

    CacheBlk()
        : asid(-1), tag(0), data(0) ,
		  size(0), status(0), whenReady(0),
          set(-1), isTouched(false), refCount(0),
          srcMasterId(Request::invldMasterId)
    {
		for (int i = 0; i <= NUM_RUNTIME_VDD_LEVELS; i++) //DPCS: init fault map booleans
			isFaultyAtVDD[i] = false;
	}

    /**
     * Copy the state of the given block into this one.
     * @param rhs The block to copy.
     * @return a const reference to this block.
     */
    const CacheBlk& operator=(const CacheBlk& rhs)
    {
        asid = rhs.asid;
        tag = rhs.tag;
        data = rhs.data;
        size = rhs.size;
        status = rhs.status;
        whenReady = rhs.whenReady;
        set = rhs.set;
        refCount = rhs.refCount;
        return *this;
    }

    /**
     * Checks the write permissions of this block.
     * @return True if the block is writable.
     */
    bool isWritable() const
    {
        const State needed_bits = BlkWritable | BlkValid; 
		if ((status & needed_bits) > 0)
			assert(!isFaulty()); //DPCS: sanity check
        return (status & needed_bits) == needed_bits;
    }

    /**
     * Checks the read permissions of this block.  Note that a block
     * can be valid but not readable if there is an outstanding write
     * upgrade miss.
     * @return True if the block is readable.
     */
    bool isReadable() const
    {
        const State needed_bits = BlkReadable | BlkValid;
		if ((status & needed_bits) > 0)
			assert(!isFaulty()); //DPCS: sanity check
        return (status & needed_bits) == needed_bits;
    }

    /**
     * Checks that a block is valid.
     * @return True if the block is valid.
     */
    bool isValid() const
    {	
		bool valid = (status & BlkValid) != 0; //DPCS
		if (valid)
			assert(!isFaulty()); //DPCS: sanity check
        return valid;
    }

    /**
     * Invalidate the block and clear all state.
     */
    void invalidate()
    {
		//DPCS: Preserve fault state on invalidate()
		int faultMap = getFaultMap(); //DPCS
		bool faulty = isFaulty();
		status = 0;
		setFaultMap(faultMap); //DPCS: "reload" fault map since status was set to 0
		setFaulty(faulty); //DPCS: "reload" faulty bit since status was set to 0
        isTouched = false;
        clearLoadLocks();
    }

    /**
     * Check to see if a block has been written.
     * @return True if the block is dirty.
     */
    bool isDirty() const
    {
		bool dirty = (status & BlkDirty) != 0; //DPCS
		if (dirty)
			assert(!isFaulty()); //DPCS: sanity check
        return dirty;
    }

    /**
     * Check if this block has been referenced.
     * @return True if the block has been referenced.
     */
    bool isReferenced() const
    {
		bool ref = (status & BlkReferenced) != 0; //DPCS
		if (ref)
			assert(!isFaulty()); //DPCS: sanity check
        return ref;
    }

    /**
     * Check if this block was the result of a hardware prefetch, yet to
     * be touched.
     * @return True if the block was a hardware prefetch, unaccesed.
     */
    bool wasPrefetched() const
    {
		bool prefetched = (status & BlkHWPrefetched) != 0; //DPCS
		if (prefetched)
			assert(!isFaulty()); //DPCS: sanity check
        return prefetched;
    }
	
	/**
	 * DPCS: isFaulty()
	 * @returns true if the block is marked as currently faulty
	 */
	bool isFaulty() const //DPCS
	{
		return (status & BlkFaulty) == BlkFaulty;
	}

	/**
	 * DPCS: setFaulty()
	 * @param faulty if true, marks the block as faulty
	 */
	void setFaulty(bool faulty) //DPCS 
	{
		if (faulty)
			status |= BlkFaulty; //set the bit
		else
			status &= ~BlkFaulty; //clear the bit
	}

	//DPCS: TODO REMOVE ME
	/**
	 * Generates fault maps for this block. This should only be called before execution begins.
	 * Returns the faultMap code generated for this block.
	 */
	/*int generateFaultMaps(const VoltageData input_vdd_data[], const int min_index, const int max_index, const int vdd3_input_index, const int vdd2_input_index, const int vdd1_input_index) //DPCS
	{
		//DPCS: We need to generate fault information for EVERY 10 mV increment due to the fault inclusion property and the fact that the BER provided by input are PMFs.

		bool faultMap_VDD[NUM_VDD_INPUT_LEVELS][MAX_BLOCK_SIZE];
		bool tmp_isFaultyAtVDD[NUM_VDD_INPUT_LEVELS];
		assert(size*8 < MAX_BLOCK_SIZE);
		assert(max_index == NUM_VDD_INPUT_LEVELS-1);
		assert(min_index == 1); //index 0 unused

		//DPCS: init
		for (int i = max_index; i >= min_index; i--) {
			assert(input_vdd_data[i].ber >= 0);
			tmp_isFaultyAtVDD[i] = false;
			for (int j = 0; j < MAX_BLOCK_SIZE; j++) {
				faultMap_VDD[i][j] = false;
			}
		}
		isFaultyAtVDD[3] = false;
		isFaultyAtVDD[2] = false;
		isFaultyAtVDD[1] = false;
		isFaultyAtVDD[0] = false;

		for (int i = max_index; i >= min_index; i--) {
			if (i < max_index) { //Fill in faulty bits from higher voltage. Skip the highest voltage.
				for (int j = 0; j < size*8; j++) {
					bool val = faultMap_VDD[i+1][j];
					faultMap_VDD[i][j] = val; //copy values from next higher VDD (fault inclusion)
					if (val == true) {
						tmp_isFaultyAtVDD[i] = true;
					}
				}
			}

			//Compute the new faults on any so-far non-faulty cells
			unsigned long outcome = 0;
			for (int j = 0; j < size*8; j++) {
				if (faultMap_VDD[i][j] == false) {
					outcome = randomGenerator.random((unsigned long) 0, input_vdd_data[i].ber_reciprocal);
					if (outcome == 1) {
					//e.g. if bitFaultRates[i] == 1e12, this should generate a random number between 0 and (1e12), inclusive. The outcome is then true if the result was exactly one fixed value, say, 0.
						faultMap_VDD[i][j] = true;
						tmp_isFaultyAtVDD[i] = true;
					}
				}
			}
		} 

		//DPCS: Keep only the relevant fault map information
		isFaultyAtVDD[3] = tmp_isFaultyAtVDD[vdd3_input_index];
		isFaultyAtVDD[2] = tmp_isFaultyAtVDD[vdd2_input_index];
		isFaultyAtVDD[1] = tmp_isFaultyAtVDD[vdd1_input_index];
		isFaultyAtVDD[0] = false; //DPCS: placeholder, unused


		//Now we have faulty bit locations for each voltage. Generate the appropriate fault map code for the status bits.
		//int faultMap = 0;
		//for (int i = 1; i <= 3; i++) {
			//if (isFaultyAtVDD[i] == true) {
				//faultMap = i;
			//}
		//}
		//setFaultMap(faultMap);

		//return faultMap;
		return 0;
	}*/

	/**
	 * DPCS: wouldBeFaulty()
	 * @param vdd the runtime VDD code to check
	 * @returns true if the block would be faulty at the given VDD level
	 */
	bool wouldBeFaulty(int vdd) //DPCS
	{
		assert(vdd >= 1 && vdd <= NUM_RUNTIME_VDD_LEVELS); //DPCS: sanity check
		if (vdd <= getFaultMap())
			return true;
		else
			return false;
	}

    /**
     * Track the fact that a local locked was issued to the block.  If
     * multiple LLs get issued from the same context we could have
     * redundant records on the list, but that's OK, as they'll all
     * get blown away at the next store.
     */
    void trackLoadLocked(PacketPtr pkt)
    {
        assert(pkt->isLLSC());
        lockList.push_front(Lock(pkt->req));
    }

    /**
     * Clear the list of valid load locks.  Should be called whenever
     * block is written to or invalidated.
     */
    void clearLoadLocks(Request *req = NULL)
    {
        if (!req) {
            // No request, invaldate all locks to this line
            lockList.clear();
        } else {
            // Only invalidate locks that overlap with this request
            std::list<Lock>::iterator lock_itr = lockList.begin();
            while (lock_itr != lockList.end()) {
                if (lock_itr->overlapping(req)) {
                    lock_itr = lockList.erase(lock_itr);
                } else {
                    ++lock_itr;
                }
            }
        }
    }

    /**
     * Pretty-print a tag, and interpret state bits to readable form
     * including mapping to a MOESI stat.
     *
     * @return string with basic state information
     */
    std::string print() const
    {
        /**
         *  state       M   O   E   S   I
         *  writable    1   0   1   0   0
         *  dirty       1   1   0   0   0
         *  valid       1   1   1   1   0
         *
         *  state   writable    dirty   valid
         *  M       1           1       1
         *  O       0           1       1
         *  E       1           0       1
         *  S       0           0       1
         *  I       0           0       0
         **/
        unsigned state = isWritable() << 2 | isDirty() << 1 | isValid();
        char s = '?';
        switch (state) {
          case 0b111: s = 'M'; break;
          case 0b011: s = 'O'; break;
          case 0b101: s = 'E'; break;
          case 0b001: s = 'S'; break;
          case 0b000: s = 'I'; break;
          default:    s = 'T'; break; // @TODO add other types
        }
        return csprintf("state: %x (%c) faulty: %d valid: %d writable: %d readable: %d " //DPCS
                        "dirty: %d tag: %x data: %x", status, s, isFaulty(), isValid(), //DPCS
                        isWritable(), isReadable(), isDirty(), tag, *data);
    }

    /**
     * Handle interaction of load-locked operations and stores.
     * @return True if write should proceed, false otherwise.  Returns
     * false only in the case of a failed store conditional.
     */
    bool checkWrite(PacketPtr pkt)
    {
        Request *req = pkt->req;
        if (pkt->isLLSC()) {
            // it's a store conditional... have to check for matching
            // load locked.
            bool success = false;

            for (std::list<Lock>::iterator i = lockList.begin();
                 i != lockList.end(); ++i)
            {
                if (i->matchesContext(req)) {
                    // it's a store conditional, and as far as the memory
                    // system can tell, the requesting context's lock is
                    // still valid.
                    success = true;
                    break;
                }
            }

            req->setExtraData(success ? 1 : 0);
            clearLoadLocks(req);
            return success;
        } else {
            // for *all* stores (conditional or otherwise) we have to
            // clear the list of load-locks as they're all invalid now.
            clearLoadLocks(req);
            return true;
        }
    }
	
	/**
	 * DPCS: getFaultMap()
	 *
	 * @returns the fault map code for this block.
	 * 0 = works at and above the 3rd highest VDD (works for all)
	 * 1 = works at and above the 2nd highest VDD
	 * 2 = works only at nominal (highest) VDD
	 * 3 = does not work at any VDD (always faulty)
	 * any other value = undef
	 */
	int getFaultMap() const //DPCS
	{
		int fault_map = 0;

		if ((status & FM1) > 0)
			fault_map += 2;
		if ((status & FM0) > 0)
			fault_map += 1;

		return fault_map;
	}

	/**
	 * DPCS: setFaultMap()
	 *
	 * This does not affect the faulty bit.
	 * @param faultMap the fault map code for this block.
	 * 0 = works at and above the 3rd highest VDD (works for all)
	 * 1 = works at and above the 2nd highest VDD
	 * 2 = works only at nominal (highest) VDD
	 * 3 = does not work at any VDD (always faulty)
	 * any other value = undef
	 *
	 * Returns true on success.
	 */
	bool setFaultMap(int faultMap) //DPCS
	{
		assert(faultMap >= 0);
		assert(faultMap <= NUM_RUNTIME_VDD_LEVELS);

		if (faultMap == 0) //DPCS: 00
			status = (status & (~FMMask)); //DPCS: Clear FM1 and FM0
		else if (faultMap == 1) //DPCS: 01
			status = (status & (~FMMask)) | FM0;
		else if (faultMap == 2) //DPCS: 10
			status = (status & (~FMMask)) | FM1;
		else if (faultMap == 3) //DPCS: 11
			status = (status | FMMask);
		else {
			panic("DPCS: block faultMap should be only 0, 1, 2, or 3! Got an illegal input value %d", faultMap);
			return false; //DPCS: I don't know why I bothered if we just panicked
		}

		return true;
	}

};

/**
 * Simple class to provide virtual print() method on cache blocks
 * without allocating a vtable pointer for every single cache block.
 * Just wrap the CacheBlk object in an instance of this before passing
 * to a function that requires a Printable object.
 */
class CacheBlkPrintWrapper : public Printable
{
    CacheBlk *blk;
  public:
    CacheBlkPrintWrapper(CacheBlk *_blk) : blk(_blk) {}
    virtual ~CacheBlkPrintWrapper() {}
    void print(std::ostream &o, int verbosity = 0,
               const std::string &prefix = "") const;
};

/**
 * Wrap a method and present it as a cache block visitor.
 *
 * For example the forEachBlk method in the tag arrays expects a
 * callable object/function as their parameter. This class wraps a
 * method in an object and presents  callable object that adheres to
 * the cache block visitor protocol.
 */
template <typename T, typename BlkType>
class CacheBlkVisitorWrapper
{
  public:
    typedef bool (T::*visitorPtr)(BlkType &blk);

    CacheBlkVisitorWrapper(T &_obj, visitorPtr _visitor)
        : obj(_obj), visitor(_visitor) {}

    bool operator()(BlkType &blk) {
        return (obj.*visitor)(blk);
    }

  private:
    T &obj;
    visitorPtr visitor;
};

/**
 * Cache block visitor that determines if there are dirty blocks in a
 * cache.
 *
 * Use with the forEachBlk method in the tag array to determine if the
 * array contains dirty blocks.
 */
template <typename BlkType>
class CacheBlkIsDirtyVisitor
{
  public:
    CacheBlkIsDirtyVisitor()
        : _isDirty(false) {}

    bool operator()(BlkType &blk) {
        if (blk.isDirty()) {
            _isDirty = true;
            return false;
        } else {
            return true;
        }
    }

    /**
     * Does the array contain a dirty line?
     *
     * \return true if yes, false otherwise.
     */
    bool isDirty() const { return _isDirty; };

  private:
    bool _isDirty;
};

/**
 * DPCS: CacheBlkIsFaultyVisitor()
 *
 * Cache block visitor that determines if there are faulty blocks in a
 * cache.
 *
 * Use with the forEachBlk method in the tag array to determine if the
 * array contains faulty blocks.
 */
template <typename BlkType>
class CacheBlkIsFaultyVisitor //DPCS
{
  public:
    CacheBlkIsFaultyVisitor()
        : _isFaulty(false) {}

    bool operator()(BlkType &blk) {
        if (blk.isFaulty()) {
            _isFaulty = true;
            return false;
        } else {
            return true;
        }
    }

    /**
     * Does the array contain a faulty line?
     *
     * \return true if yes, false otherwise.
     */
    bool isFaulty() const { return _isFaulty; };

  private:
    bool _isFaulty;
};

/**
 * Cache block visitor that determines if there are faulty blocks in a
 * cache.
 *
 * Use with the forEachBlk method in the tag array to determine if the
 * array contains faulty blocks.
 */
/*template <typename BlkType>
class GenerateFaultMapsVisitor //DPCS: TODO REMOVE ME
{
  public:
    GenerateFaultMapsVisitor(){}

    bool operator()(BlkType &blk) {
        blk.generateFaultMaps();
		return true;
    }
};
*/
#endif //__CACHE_BLK_HH__
