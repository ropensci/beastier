#!/bin/bash
#
# Create the Singularity container 'beastier.sif'
#
# Usage:
#
#  ./scripts/create_singularity_container.sh
#
singularity build --fakeroot beastier.sif Singularity
