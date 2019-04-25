#!/bin/bash
# Script to install pirouette and its dependencies
# on the Peregrine computer cluster
# 
# Usage:
#
# * To install master:
#
# sbatch install
#
# * To install a branch, e.g. develop:
#
# sbatch install develop
#
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=install_beastier
#SBATCH --output=install_beastier.log
branch=$1
if [ "$#" -ne 1 ]; then
  branch=master
fi

module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
module load ImageMagick
Rscript -e "devtools::install_github(\"ropensci/beastier\", ref = \"$branch\")" 
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
