//Author: Mark Gottscho <mgottscho@ucla.edu>

#ifndef __PCS_LEVEL_HH__
#define __PCS_LEVEL_HH__

#define NUM_RUNTIME_VDD_LEVELS 3
#define NUM_INPUT_VDD_LEVELS 101

//DPCS
class PCSLevel
{
	public:
		/**
		 * DPCS: default constructor
		 * */
		PCSLevel() :
					__vdd(0),
					__ber(0),
					__block_error_rate(0),
					__staticPower(0),
					__accessEnergy(0),
					__nfb(0),
					__valid(false) { }
		
		/**
		 * DPCS: specialized constructor
		 */
		PCSLevel(int vdd, double ber, double block_error_rate, double staticPower, double accessEnergy, unsigned long nfb) :
					__vdd(vdd),
					__ber(ber),
					__block_error_rate(block_error_rate),
					__staticPower(staticPower),
					__accessEnergy(accessEnergy),
					__nfb(nfb),
					__valid(true) { }

		/**
		 * DPCS: getVDD()
		 * @returns VDD level in mV for this cache PCS level
		 */
		int getVDD() { return __vdd; }

		/**
		 * DPCS: getBER()
		 * @returns bit error rate as a probability
		 */
		double getBER() { return __ber; }

		/**
		 * DPCS: getBlockErrorRate()
		 * @returns block error rate as a probability
		 */
		double getBlockErrorRate() { return __block_error_rate; }

		/**
		 * DPCS: getStaticPower()
		 * @returns total cache static power in mW for this VDD level
		 */
		double getStaticPower() { return __staticPower; }

		/**
		 * DPCS: getAccessEnergy()
		 * @returns total cache dynamic energy per access in nJ for this VDD level
		 */
		double getAccessEnergy() { return __accessEnergy; }

		/**
		 * DPCS: getNFB()
		 * @returns the total number of faulty blocks in this cache for this VDD level
		 */
		unsigned long getNFB() { return __nfb; }

		/**
		 * DPCS: isValid()
		 * @returns true if the data in this object is valid
		 */
		bool isValid() { return __valid; }

		/**
		 * DPCS: setVDD()
		 * @param vdd the voltage level in mV for this VDD level
		 */
		void setVDD(int vdd) { __vdd = vdd; }
		
		/**
		 * DPCS: setBER()
		 * @param set the bit error rate for this VDD level
		 */
		void setBER(double ber) { __ber = ber; }

		/**
		 * DPCS: setBlockErrorRate()
		 * @param set the block error rate for this VDD level
		 */
		void setBlockErrorRate(double block_error_rate) { __block_error_rate = block_error_rate; }

		/**
		 * DPCS: setStaticPower()
		 * @param staticPower total cache static power in mW for this VDD level
		 */
		void setStaticPower(double staticPower) { __staticPower = staticPower; }

		/**
		 * DPCS: setAccessEnergy()
		 * @param accessEnergy total cache dynamic energy per access in nJ for this VDD level
		 */
		void setAccessEnergy(double accessEnergy) { __accessEnergy = accessEnergy; }

		/**
		 * DPCS: setNFB()
		 * @param nfb total number of faulty blocks in this cache for this VDD level
		 */
		void setNFB(unsigned long nfb) { __nfb = nfb; }

		/**
		 * DPCS: setValid()
		 * @param valid if true, marks this object as valid, else invalid
		 */
		void setValid(bool valid) { __valid = valid; }

	private:
		int __vdd; //in mV
		double __ber; //bit error rate. not actually used right now in simulation but here for completeness
		double __block_error_rate; //block error rate, not actually used right now in simulation but here for completeness
		double __staticPower; //in mW
		double __accessEnergy; //in nJ
		unsigned long __nfb; //number of faulty blocks at the given vdd
		bool __valid; //flag indicating whether the object contains valid data
};

#endif
