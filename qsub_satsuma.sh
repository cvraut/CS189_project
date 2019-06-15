#!/bin/bash
#
#$ -N satsuma_yeast_script
#$ -t 1-4        ## task ids
#$ -q pub8i      ## queue to send task to
## -ckpt restart ## include to make sure tasks are suspended & restart. Only for use in suspendable queues.
### -m beas
### -M craut@uci.edu
### -o
### -e
#$ -pe openmp 2  ## for multithreaded applications. pe openmp INT, integer is # of cores

conda activate cg_yeast
## cactus -h
## SatsumaSynteny2 -h
cd outputs
rm -rf *.*
cd ..
echo "Running Satsuma"
export SATSUMA2_PATH=~/bin/miniconda3/envs/cg_yeast/bin


cd data
REF=$(cat dat.ls | head -n 1)
SEED=$(cat dat.ls | head -n $((${SGE_TASK_ID}+1)) | tail -n 1)
cd ..
SEED=${SEED%%.*}
rm -rf ./outputs/${SEED}
mkdir -p ./outputs/${SEED}

echo "$((${SGE_TASK_ID}+1))"
echo "${REF}"
echo "${SEED}"

SatsumaSynteny2 -t data/${REF} -q data/${SEED}.fasta -o outputs/${SEED}

conda deactivate