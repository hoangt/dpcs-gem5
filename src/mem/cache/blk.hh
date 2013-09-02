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

#include "base/printable.hh"
#include "mem/packet.hh"
#include "mem/request.hh"
#include "sim/core.hh"          // for Tick

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
	/** Bit 0 of this block's fault map. This is NOT cleared on invalidate, it persists throughout execution. */	
	FM0 =				0x040, //DPCS
	/** Bit 1 of this block's fault map. This is NOT cleared on invalidate, it persists throughout execution. */	

	FM1 =				0x080, //DPCS
	/** Flag indicating if this block is faulty at the current VDD. If this is 1, the block MUST be invalid. This is NOT cleared on invalidate, it persists throughout execution. It is only updated when cache VDD is scaled. */	

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
  	
	typedef std::array<bool> BitFaults; //DPCS
	BitFaults faultMap_VDD[3]; //DPCS: FIXME: This needs to be initialized properly

  
  public:

    CacheBlk()
        : asid(-1), tag(0), data(0) ,
		  faultMap_VDD[0](0), faultMap_VDD[1](0), faultMap_VDD[2](0),//DPCS
		  size(0), status(0), whenReady(0),
          set(-1), isTouched(false), refCount(0),
          srcMasterId(Request::invldMasterId)
    {}

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
		faultMap_VDD = rhs.faultMap_VDD; //DPCS: FIXME: Is this correct?
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
		if (status & needed_bits > 0)
			assert(!isFaulty()); //sanity check
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
		if (status & needed_bits > 0)
			assert(!isFaulty()); //sanity check
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
			assert(!isFaulty()); //sanity check
        return valid;
    }

    /**
     * Invalidate the block and clear all state.
     */
    void invalidate()
    {
		//Preserve fault state on invalidate()
		int faultMap = getFaultMap(); //DPCS
		bool faulty = isFaulty();
		status = 0;
		if (faulty)
			status = 0 | BlkFaulty; //reload faulty bit
		setFaultMap(faultMap); //reload fault map
        isTouched = false;
		//DPCS: FIXME: shouldn't refCount be reset?
		//DPCS: FIXME: shouldn't tag be reset?
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
			assert(!isFaulty()); //sanity check
        return dity;
    }

    /**
     * Check if this block has been referenced.
     * @return True if the block has been referenced.
     */
    bool isReferenced() const
    {
		bool ref = (status & BlkReferenced) != 0; //DPCS
		if (ref)
			assert(!isFaulty()); //sanity check
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
			assert(!isFaulty()); //sanity check
        return prefetched;
    }
	
	/**
	 * Checks that a block is faulty.
	 */
	bool isFaulty() const //DPCS
	{
		return (status & BlkFaulty) == BlkFaulty;
	}

	/**
	 * Some assertions to make sure faulty bit behavior is not catastrophically wrong
	 */
	/*void faultSanityCheck() const //DPCS
	{
		if (isFaulty()) {
			//Make sure all state is cleared, and fault map is not impossible
			assert(!isValid());
			assert(!isWritable());
			assert(!isReadable());
			assert(!isDirty());
			assert(!isReferenced());
			assert(!wasPrefetched());
			assert(getFaultMap() > 0);
		}
	}*/

	/**
	 * Returns the fault map code for this block.
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
	}

	/**
	 * Sets the fault map bits for this block to the corresponding value in the parameter. This does not affect the faulty bit.
	 * Returns true on success.
	 */
	bool setFaultMap(int faultMap) //DPCS
	{
		assert(faultMap >= 0);
		assert(faultMap <= 3);

		if (faultMap == 0) //00
			status = (status & (~FMMask)); //Clear FM1 and FM0
		else if (faultMap == 1) //01
			status = (status & (~FMMask)) | FM0;
		else if (faultMap == 2) //10
			status = (status & (~FMMask)) | FM1;
		else if (faultMap == 3) //11
			status = (status | FMMask);
		else {
			panic("faultMap should be only 0, 1, 2, or 3! Got an illegal input value %d", faultMap);
			return false;
		}

		return true;
	}

	/**
	 * Generates fault maps for this block given bit cell failure probability for VDD0, 1, and 2. This should only be called before execution begins.
	 * VDD0 = lowest VDD
	 * VDD1 = mid VDD
	 * VDD2 = high VDD
	 * Returns the faultMap code generated for this block.
	 */
	int generateFaultMaps(double bitFaultRates[3]) //DPCS
	{
		bool is_faulty_block_at_vdd[3];
		for (int i = 2; i >= 0; i--) { //init, sanity checks
			assert(bitFaultRates[i] >= 0);
			assert(faultMap_VDD[i] != NULL);
			assert(faultMap_VDD[i].length == size*8);
			is_faulty_block_at_vdd[i] = false;
		}

		//Go from high voltage to low voltage, using fault inclusion property to carry over faults from higher VDD
		for (int i = 2; i >= 0; i--) {
			//Initialize the fault map. It should already be allocated
			for (int j = 0; j < size*8 j++) {
				if (i == 2) { //highest VDD
					faultMap_VDD[i][j] = false;
				} else {
					bool val = faultMap_VDD[i+1][j];
					faultMap_VDD[i][j] = val; //copy values from next higher VDD (fault inclusion)
					if (val == true) {
						is_faulty_block_at_vdd[i] = true;
					}
				}
			}

			//Compute the new faults on any so-far non-faulty cells
			for (int j = 0; j < size*8; j++) {
				if (faultMap_VDD[i][j] == false) {
					bool outcome = (rand() % (1/bitFaultRates[i])) == 0; //e.g. if bitFaultRates[i] == 1e-12, this should generate a random number between 0 and (1e12)-1. The outcome is then true if the result was exactly one fixed value, say, 0.
					faultMap_VDD[i][j] == outcome;
					if (outcome == true)
						is_faulty_block_at_vdd[i] = true;
				}
			}
		} 

		//Now we have faulty bit locations for each voltage. Generate the appropriate fault map code for the status bits.
		int faultMap = 0;
		for (int i = 2; i >= 0; i--) {
			if (is_faulty_block_at_vdd[i] == true) {
				faultMap = i+1;
				break;
			}
		}
		setFaultMap(faultMap);

		return faultMap;
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

#endif //__CACHE_BLK_HH__
