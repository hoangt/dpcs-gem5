function [faultmap,vdd_ber] = generate_fault_map(param_filename,cache_size,assoc)
% Author: Mark Gottscho
% mgottscho@ucla.edu
% 
% This function computes the minimum non-faulty VDD for each cache block.
% See the README for more details on expected file formats in the dpcs-gem5
% framework.
%
% Arguments:
%   param_filename -- the CSV file to read
%   cache_size -- total number of blocks in the cache
%   assoc -- cache associativity
% 
% Returns:
%   faultmap -- a matrix, where each entry represents the minimum non-faulty
%       VDD the corresponding block can operate at. Voltage levels and
%       units match those in the input parameter file. Rows correspond to
%       cache sets while columns correspond to cache ways.


% Read the file, init
raw_file_input = csvread(param_filename, 1, 0);
vdd_ber = raw_file_input(:,1:2); % Extract just VDD and bit error rates from input
vdd_min = vdd_ber(size(vdd_ber,1),1);
rows = cache_size/assoc; % Number of cache sets
cols = assoc;
faultmap = zeros(rows,cols);


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
    
    tmp_faultmap = randi([0, ber_reciprocal], rows, cols);
    tmp_faultmap2 = zeros(rows,cols);
    tmp_faultmap2( tmp_faultmap(:,:) == 0 ) = last_vdd;
    faultmap( faultmap(:,:) == 0 ) = tmp_faultmap2( faultmap(:,:) == 0 );
end

% Anything in faultmap marked 0 is non-faulty at all input VDD levels. Set them all to min-VDD.
faultmap( faultmap(:,:) == 0 ) = vdd_min;