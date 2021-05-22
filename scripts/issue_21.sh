#!/bin/bash
# Script to investigate Issue #21
# This script can be run as-is, as it will 
# sbatch the needed jobs itself
#
# Usage:
#
# ./issue_21
#
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100M
#SBATCH --job-name=issue_21
#SBATCH --output=issue_21_%j.log
for rng_seed in $(seq 1 100)
do
  sbatch run_r_script issue_21.R
  sleep 1
done
