function [bit_faultmap,block_faultmap] = generate_fault_map(param_filename,cache_size,assoc,bytes_per_block)
% Author: Mark Gottscho
% mgottscho@ucla.edu
% 
% This function computes the minimum non-faulty VDD for each cache block.
% See the README for more details on expected file formats in the dpcs-gem5
% framework.
%
% Arguments:
%   param_filename -- the CSV file to read
%   cache_size -- total cache size in bytes
%   assoc -- cache associativity
%   bytes_per_block -- number of bytes in each cache block
% 
% Returns:
%   bit_faultmap -- a matrix, where each entry represents the minimum non-faulty
%       VDD the corresponding bit can operate at. Voltage levels and
%       units match those in the input parameter file. Rows correspond to
%       cache sets while columns correspond to bits in each set (multiple ways).
%   block_faultmap -- a matrix like bit_faultmap, but each column represents a block rather than
%       a single bit. A block is faulty at a given VDD if any of its bits are faulty
%       at that VDD.


% Read the file, init
raw_file_input = csvread(param_filename, 1, 0);
vdd_ber = raw_file_input(:,1:2); % Extract just VDD and bit error rates from input
vdd_min = vdd_ber(size(vdd_ber,1),1);

bit_cols = assoc * bytes_per_block * 8; % Number of bits in a cache set
sets = cache_size*8/bit_cols; % Number of cache sets
bit_faultmap = zeros(sets,bit_cols);

% Iterate from highest VDD (first in file) to lowest VDD.
% For each block at current VDD, roll a die to see if the block would be faulty.
% If so, save it in the fault map and leave it alone. Otherwise, keep
% rolling the die for the remaining non-faulty blocks at each successively
% lower VDD.
%
% NOTE: We assume that the BER provided by input file is a PMF (independent
% for each voltage).
vdd = vdd_ber(1,1); % Init
for i = 2:size(vdd_ber,1) % Skip nominal VDD, assume always non-faulty
    last_vdd = vdd;
    vdd = vdd_ber(i,1);
    ber = vdd_ber(i,2);
    ber_reciprocal = uint64(1/ber);
    
    tmp_faultmap = randi([0, ber_reciprocal], sets, bit_cols);
    tmp_faultmap2 = zeros(sets,bit_cols);
    tmp_faultmap2( tmp_faultmap(:,:) == 0 ) = last_vdd;
    bit_faultmap( bit_faultmap(:,:) == 0 ) = tmp_faultmap2( bit_faultmap(:,:) == 0 );
end

% Anything in faultmap marked 0 is non-faulty at all input VDD levels. Set them all to min-VDD.
bit_faultmap( bit_faultmap(:,:) == 0 ) = vdd_min;

% Now compute the block_faultmap using bit_faultmap (aggregation)
block_faultmap = zeros(sets,assoc);
for set = 1:sets
    for way = 1:assoc
        block_faultmap(set,way) = max(bit_faultmap(set,1+(way-1)*bytes_per_block*8:way*bytes_per_block*8));
    end
end