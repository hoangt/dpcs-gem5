#!/bin/bash

./extract_results.sh m5out/A "1 2 3 4 5" > m5out/A_results.csv &
./extract_results.sh m5out/B "1 2 3 4 5" > m5out/B_results.csv &
