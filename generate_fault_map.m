function [block_faultmap] = generate_fault_map(vdd_block_error_rate,cache_size,assoc,bytes_per_block)
% Author: Mark Gottscho
% mgottscho@ucla.edu
% 
% This function computes the minimum non-faulty VDD for each cache block.
% See the README for more details on expected file formats in the dpcs-gem5
% framework.
%
% Arguments:
%   vdd_block_error_rate -- Nx2 matrix where column 1 is the VDD and column 2 is the block error rate
%   cache_size -- total cache size in bytes
%   assoc -- cache associativity
%   bytes_per_block -- number of bytes in each cache block
% 
% Returns:
%   block_faultmap -- a matrix, where each entry represents the minimum non-faulty
%       VDD the corresponding block can operate at. Voltage levels and
%       units match those in the input parameter file. Rows correspond to
%       cache sets while columns correspond to blocks in each set (different ways).

vdd_input_min = vdd_block_error_rate(size(vdd_block_error_rate,1),1); % Minimum VDD specified in the input file
sets = cache_size/(assoc*bytes_per_block); % Number of cache sets

% Create the block-level fault map
block_faultmap = zeros(sets,assoc);

% Iterate from highest VDD (first in file) to lowest VDD.
% For each block at current VDD, roll a die to see if the block would be faulty.
% If so, save it in the fault map and leave it alone. Otherwise, keep
% rolling the die for the remaining non-faulty blocks at each successively
% lower VDD. This is the "fault inclusion property" mentioned in DPCS DAC'14 paper
%
% NOTE: We assume that the BER provided by input file is a PMF (independent
% for each voltage), and is at bit-level not block-level.

vdd = vdd_block_error_rate(1,1); % Init
for i = 2:size(vdd_block_error_rate,1) % Skip nominal VDD, assume always non-faulty
    last_vdd = vdd;
    vdd = vdd_block_error_rate(i,1);
    ber = vdd_block_error_rate(i,2);

	% Ensure that ber is > 0 to roll die
	if ber > 0
		ber_reciprocal = uint64(1/ber); % Need to invert for integer random number generation
	   
		% Roll a fair die from 0 to ber_reciprocal (potentially very large!)
		% We consider a "block fault" if the outcome is exactly 0
		tmp_faultmap = randi([0, ber_reciprocal], sets, assoc);
	else
		tmp_faultmap = ones(sets,assoc); % Ensure no faults are flagged in the special case where ber is 0		
	end

	% Update the faultmap
    tmp_faultmap2 = zeros(sets,assoc);
    tmp_faultmap2( tmp_faultmap(:,:) == 0 ) = last_vdd;
    block_faultmap( block_faultmap(:,:) == 0 ) = tmp_faultmap2( block_faultmap(:,:) == 0 );
end

% Anything in faultmap marked 0 is non-faulty at all input VDD levels. Set them all to min-VDD.
block_faultmap( block_faultmap(:,:) == 0 ) = vdd_input_min;
