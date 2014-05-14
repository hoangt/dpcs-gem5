function [bit_faultmaps, block_faultmaps, vdd_mins, vdd_mins_nonfaulty] = generate_fault_maps(param_filename,cache_size,assoc,bytes_per_block,map_numbers,output_enable,output_dir,cache_ID,config_ID)
% Author: Mark Gottscho
% mgottscho@ucla.edu
%
% This function automates the generation of several fault map files for use in the
% gem5 simulation.
%
% See the README for more details on expected file formats in the dpcs-gem5
% framework.
%
% Arguments:
%   param_filename -- the CSV file to read
%   cache_size -- total cache size in bytes
%   assoc -- cache associativity
%   bytes_per_block -- number of bytes in each cache block
%   map_numbers -- row vector of numbers identifying unique fault maps for use in matching
%       Monte Carlo simulation, e.g. [1:5] for 5 unique fault maps.
%   output_enable -- 1 if you want files to be generated
%   output_dir -- path to directory to save fault map files
%   cache_ID -- string representing which cache, e.g. "L2"
%   config_ID -- string representing the system configuration, e.g. "foo"
%
%
% Returns:
%   bit_faultmaps -- a 3D matrix where each Z plane corresponds to a single bit_faultmap
%   block_faultmaps -- a 3D matrix where each Z plane corresponds to a single block_faultmap
%   vdd_mins -- a row vector where each element corresponds to the minimum VDD
%       for the corresponding block_faultmap. This is found as the max of
%       the minimum VDD for all blocks in the map, or the min voltage
%       such that all sets have at least one non-faulty block.
%   vdd_mins_nonfaulty -- a row vector where each element corresponds to the minimum VDD
%       the cache could be operated without any faults.
% 
% Outputs:
%   If output_enable is set to 1, two CSV files will be produced for each 
%   unique fault map generated, of the form:
%
%   <output_dir>/faultmap-<cache_ID>-<config_ID>-<map_number>-bitwise.csv
%   <output_dir>/faultmap-<cache_ID>-<config_ID>-<map_number>-blockwise.csv
%
%   Where each entry in bitwise CSV represents a single bit, and each entry
%   in blockwise CSV represents a single block.
%
%   For example, with the input arguments:
%       output_dir = 'faultmaps'
%       cache_ID = 'L2'
%       config_ID = 'foo'
%       map_numbers = [1:5]
%
%   The following files will be produced:
%       faultmaps/faultmap-L2-foo-1-bitwise.csv
%       faultmaps/faultmap-L2-foo-1-blockwise.csv
%       faultmaps/faultmap-L2-foo-2-bitwise.csv
%       faultmaps/faultmap-L2-foo-2-blockwise.csv
%       faultmaps/faultmap-L2-foo-3-bitwise.csv
%       faultmaps/faultmap-L2-foo-3-blockwise.csv
%       faultmaps/faultmap-L2-foo-4-bitwise.csv
%       faultmaps/faultmap-L2-foo-4-blockwise.csv
%       faultmaps/faultmap-L2-foo-5-bitwise.csv
%       faultmaps/faultmap-L2-foo-5-blockwise.csv

sets = cache_size/(assoc*bytes_per_block);

% Inform user
display(['Generating ' num2str(map_numbers(size(map_numbers,2))) ' fault maps...']);
display(['Cache config: ' num2str(cache_size) ' B, ' num2str(assoc) '-way, ' num2str(sets) ' sets, ' num2str(bytes_per_block) ' B/block']);

% Generate the fault maps and optionally output to files
% Prepare
%bit_faultmaps = NaN(sets,assoc*bytes_per_block*8,map_numbers(size(map_numbers,2))); % Allocate a 3D matrix. Each Z plane is one bit_faultmap. Z indices correspond to map_number indices that were input.
block_faultmaps = NaN(sets,assoc,map_numbers(size(map_numbers,2))); % Allocate a 3D matrix. Each Z plane is one block_faultmap. Z indices correspond to map_number indices that were input.
vdd_mins = NaN(1,map_numbers(size(map_numbers,2))); % Row vector of vdd_mins for each block_faultmap
vdd_mins_nonfaulty = NaN(1,map_numbers(size(map_numbers,2))); % Row vector of vdd_mins_nonfaulty for each block faultmap

for i = 1:size(map_numbers,2)
    map_number = map_numbers(i);
    
    display(['Generating fault map ' num2str(map_number) '...']);
    [bit_faultmap, block_faultmap] = generate_fault_map(param_filename, cache_size, assoc, bytes_per_block);
    %bit_faultmaps(:,:,map_number) = bit_faultmap;
    block_faultmaps(:,:,map_number) = block_faultmap;
    
    setwise_vdd_mins = min(block_faultmaps(:,:,map_number)')'; % For each set, see what the minimum VDD is. This is because each set must have at least one non-faulty block.
    vdd_mins(map_number) = max(min(min(block_faultmaps(:,:,map_number))), max(setwise_vdd_mins)); % Take the maximum of maximum setwise vdd mins, and the minimum VDD seen anywhere. 
    % NOTE: Actually I am pretty sure this is redundant, since max of max setwise vdd mins should always be >= min VDD
    % anywhere. Oh well I'll leave it for now.
    
    vdd_mins_nonfaulty(map_number) = max(max(block_faultmaps(:,:,map_number))); % VDD min for nonfaulty cache would be max of all blockwise min VDDs
    
    if output_enable == 1
        csvwrite([output_dir '/faultmap-' cache_ID '-' config_ID '-' num2str(map_number) '-bitwise.csv'], bit_faultmap);
        csvwrite([output_dir '/faultmap-' cache_ID '-' config_ID '-' num2str(map_number) '-blockwise.csv'], block_faultmap);
    end
end