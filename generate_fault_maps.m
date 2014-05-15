function [block_faultmaps, vdd_mins, vdd_mins_nonfaulty] = generate_fault_maps(param_filename,cache_size,assoc,bytes_per_block,map_numbers,output_enable,output_dir,cache_ID,config_ID)
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
%   block_faultmaps -- a 3D matrix where each Z plane corresponds to a single block_faultmap
%   vdd_mins -- a row vector where each element corresponds to the minimum VDD
%       for the corresponding block_faultmap. This is found as the max of
%       the minimum VDD for all blocks in the map, or the min voltage
%       such that all sets have at least one non-faulty block.
%   vdd_mins_nonfaulty -- a row vector where each element corresponds to the minimum VDD
%       the cache could be operated without any faults.
% 
% Outputs:
%   If output_enable is set to 1, one CSV file will be produced for each 
%   unique fault map generated, of the form:
%
%   <output_dir>/faultmap-<cache_ID>-<config_ID>-<map_number>.csv
%
%   Where each entry represents a single block.
%
%   For example, with the input arguments:
%       output_dir = 'faultmaps'
%       cache_ID = 'L2'
%       config_ID = 'foo'
%       map_numbers = [1:5]
%
%   The following files will be produced:
%       faultmaps/faultmap-L2-foo-1.csv
%       faultmaps/faultmap-L2-foo-2.csv
%       faultmaps/faultmap-L2-foo-3.csv
%       faultmaps/faultmap-L2-foo-4.csv
%       faultmaps/faultmap-L2-foo-5.csv

sets = cache_size/(assoc*bytes_per_block);

% Inform user
display(['Generating ' num2str(map_numbers(size(map_numbers,2))) ' fault maps...']);
display(['Cache config: ' num2str(cache_size) ' B, ' num2str(assoc) '-way, ' num2str(sets) ' sets, ' num2str(bytes_per_block) ' B/block']);

% Read the file, init
raw_file_input = csvread(param_filename, 1, 0);
vdd_block_error_rate = raw_file_input(:,1:2); % Extract just VDD and block error rates from input

% Generate the fault maps and optionally output to files
block_faultmaps = NaN(sets,assoc,map_numbers(size(map_numbers,2))); % Allocate a 3D matrix. Each Z plane is one block_faultmap. Z indices correspond to map_number indices that were input.
vdd_mins = NaN(1,map_numbers(size(map_numbers,2))); % Row vector of vdd_mins for each block_faultmap
vdd_mins_nonfaulty = NaN(1,map_numbers(size(map_numbers,2))); % Row vector of vdd_mins_nonfaulty for each block faultmap

% Set up for parallel execution of the loop
% You should set up the matlabpool before calling the function.
if matlabpool('size') == 0
	display('Spawning new matlabpool...');
	matlabpool open 8
end

worker_count = matlabpool('size');
display(['Generating using matlabpool size of ' num2str(worker_count) ' workers']);

% Parallel for loop. Each iteration is independent of the others, except for the block_faultmaps aggregation. This should scale to many threads if possible.
parfor map_number = map_numbers(1:size(map_numbers,2))
    display(['Generating fault map ' num2str(map_number) '...']);
    block_faultmap = generate_fault_map(vdd_block_error_rate, cache_size, assoc, bytes_per_block);
    
    setwise_vdd_mins = min(block_faultmaps(:,:,map_number)')'; % For each set, see what the minimum VDD is. This is because each set must have at least one non-faulty block.
    vdd_mins(map_number) = max(setwise_vdd_mins); % Take the maximum of setwise vdd mins for correct operation
    vdd_mins_nonfaulty(map_number) = max(max(block_faultmaps(:,:,map_number))); % VDD min for nonfaulty cache would be max of all blockwise min VDDs
    
	block_faultmaps(:,:,map_number) = block_faultmap; % save the faultmap into data structure
    
    if output_enable == 1 % Output faultmap to file, needed for simulation purposes
        csvwrite([output_dir '/faultmap-' cache_ID '-' config_ID '-' num2str(map_number) '.csv'], block_faultmap);
    end
end
