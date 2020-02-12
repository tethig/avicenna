#!/bin/bash
#SBATCH --job-name=thinking
#SBATCH -N 1 -c 2 --mem=16G
#SBATCH --time=0-0:1:0
#SBATCH --mail-user=EMAIL HERE
#SBATCH --mail-type=ALL
#SBATCH --output=/users/n0000000/thinking_%j.log

pwd; hostname; date
echo "Starting job"
echo "I am thinking"
echo "Finished job"
date
