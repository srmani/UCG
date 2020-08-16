#!/bin/bash

#SBATCH --partition=gavoth-brw
#SBATCH --qos=gavoth
#SBATCH --exclusive
#SBATCH --nodes=1
#SBATCH --job-name=dist3
#SBATCH --time=24:00:00

module load intel intelmpi
module load matlab

sh IndividualStatesTimeProfile.sh 1 1 IndividualStates
