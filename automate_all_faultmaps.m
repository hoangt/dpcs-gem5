% Author: Mark Gottscho
% mgottscho@ucla.edu
%
% This script automates semi-parallel processing of many, many fault maps
% for different cache configurations.

% Compute L1-A fault maps
%display('L1-A fault maps...');
%[block_faultmaps_L1_A, vdd_mins_L1_A, vdd_mins_nonfaulty_L1_A] = generate_fault_maps('parameters/gem5params-L1-A.csv', 65536, 4, 64, [1:10000], 1, 'faultmaps', 'L1', 'A');
%save('faultmaps/faultmaps_L1_A.mat');
%clear;

% Compute L2-A fault maps
display('L2-A fault maps...');
[block_faultmaps_L2_A, vdd_mins_L2_A, vdd_mins_nonfaulty_L2_A] = generate_fault_maps('parameters/gem5params-L2-A.csv', 2097152, 8, 64, [1:10000], 1, 'faultmaps', 'L2', 'A');
save('faultmaps/faultmaps_L2_A.mat');
clear;

% Compute L1-B fault maps
display('L1-B fault maps...');
[block_faultmaps_L1_B, vdd_mins_L1_B, vdd_mins_nonfaulty_L1_B] = generate_fault_maps('parameters/gem5params-L1-B.csv', 262144, 4, 64, [1:10000], 1, 'faultmaps', 'L1', 'B');
save('faultmaps/faultmaps_L1_B.mat');
clear;

% Compute L2-B fault maps
display('L2-B fault maps...');
[block_faultmaps_L2_B, vdd_mins_L2_B, vdd_mins_nonfaulty_L2_B] = generate_fault_maps('parameters/gem5params-L2-B.csv', 8388608, 16, 64, [1:10000], 1, 'faultmaps', 'L2', 'B');
save('faultmaps/faultmaps_L2_B.mat');
clear

display('DONE!!!!!!');