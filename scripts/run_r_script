#!/bin/bash
# Bash script to run an R script with sbatch
#
# Usage:
#
# sbatch run_r_script create_example_1.R
#
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run_r_script
#SBATCH --output=run_r_script_%j.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
module load ImageMagick
module load X11
module load cairo
xvfb-run Rscript "$@"
