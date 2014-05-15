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
					vdd(0),
					staticPower(0),
					accessEnergy(0),
					nfb(0),
					valid(false) { }
		
		/**
		 * DPCS: specialized constructor
		 */
		PCSLevel(double vdd, double staticPower, double accessEnergy, unsigned long nfb, bool valid) :
					vdd(vdd),
					staticPower(staticPower),
					accessEnergy(accessEnergy),
					nfb(nfb),
					valid(valid) { }

		/**
		 * DPCS: getVDD()
		 * @returns VDD level in mV for this cache PCS level
		 */
		double getVDD() { return vdd; }

		/**
		 * DPCS: getStaticPower()
		 * @returns total cache static power in mW for this VDD level
		 */
		double getStaticPower() { return staticPower; }

		/**
		 * DPCS: getAccessEnergy()
		 * @returns total cache dynamic energy per access in nJ for this VDD level
		 */
		double getAccessEnergy() { return accessEnergy; }

		/**
		 * DPCS: getNFB()
		 * @returns the total number of faulty blocks in this cache for this VDD level
		 */
		unsigned long getNFB() { return nfb; }

		/**
		 * DPCS: isValid()
		 * @returns true if the data in this object is valid
		 */
		bool isValid() { return valid; }

		/**
		 * DPCS: setVDD()
		 * @param vdd the voltage level in mV for this VDD level
		 */
		void setVDD(double vdd) { this.vdd = vdd; }
		
		/**
		 * DPCS: setStaticPower()
		 * @param staticPower total cache static power in mW for this VDD level
		 */
		void setStaticPower(double staticPower) { this.staticPower = staticPower; }

		/**
		 * DPCS: setAccessEnergy()
		 * @param accessEnergy total cache dynamic energy per access in nJ for this VDD level
		 */
		void setAccessEnergy(double accessEnergy) { this.accessEnergy = accessEnergy; }

		/**
		 * DPCS: setNFB()
		 * @param nfb total number of faulty blocks in this cache for this VDD level
		 */
		void setNFB(unsigned long nfb) { this.nfb = nfb; }

		/**
		 * DPCS: setValid()
		 * @param valid if true, marks this object as valid, else invalid
		 */
		void setValid(bool valid) { this.valid = valid; }

	private:
		double vdd; //in mV
		double staticPower; //in mW
		double accessEnergy; //in nJ
		unsigned long nfb; //number of faulty blocks at the given vdd
		bool valid; //flag indicating whether the object contains valid data
};

#endif
