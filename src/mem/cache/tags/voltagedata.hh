//Author: Mark Gottscho <mgottscho@ucla.edu>

#ifndef __VOLTAGE_DATA_HH__
#define __VOLTAGE_DATA_HH__

#define NUM_VDD_LEVELS 3
#define NUM_VDD_INPUT_LEVELS 101

//DPCS
class VoltageData
{
	public:
		double vdd; //in mV
		double ber; //bit error rate
		unsigned long ber_reciprocal; //reciprocal of the bit error rate, for random number generation using whole numbers
		double staticPower; //in mW
		double accessEnergy; //in nJ
//		double totalDynamicEnergy; //in nJ, accumulated
		unsigned long nfb; //number of faulty blocks
		bool valid; //flag indicating whether the object contains valid data

		VoltageData() {
			vdd = 0;
			ber = 0;
			ber_reciprocal = 0;
			staticPower = 0;
			accessEnergy = 0;
	//		totalDynamicEnergy = 0;
			nfb = 0;
			valid = false;
		}
};

#endif
