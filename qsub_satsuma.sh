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
#$ -pe openmp 1  ## for multithreaded applications. pe openmp INT, integer is # of cores

source ~/.miniconda3rc
cd /pub/{$USER}/CS189_project
conda --version
conda activate cg_yeast
## cactus -h
## SatsumaSynteny2 -h
cd outputs
rm -rf *.*
cd ..
echo "Running Satsuma"
export SATSUMA2_PATH=~/bin/miniconda3/envs/cg_yeast/bin/
## run satsuma
#mkdir ./outputs/suvarum_cbs7001
#SatsumaSynteny2 -q data/g833-1B_reference.fasta -t data/suvarum_cbs7001.fasta -o outputs/suvarum_cbs7001
#mkdir ./outputs/S288C_reference
#SatsumaSynteny2 -q data/g833-1B_reference.fasta -t data/S288C_reference.fasta -o outputs/S288C_reference
#mkdir ./outputs/SK1_reference
#SatsumaSynteny2 -q data/g833-1B_reference.fasta -t data/SK1_reference.fasta -o outputs/SK1_reference
#mkdir ./outputs/W303_reference
#SatsumaSynteny2 -q data/g833-1B_reference.fasta -t data/W303_reference.fasta -o outputs/W303_reference

cd data
REF=$(ls -1c *.fasta | head -n 1)
SEED=$(ls -1c *.fasta | head -n ${SGE_ARRAY_TASK_ID+1} | tail -n 1)
cd ..
rm -rf ./outputs/${SEED}
mkdir -p ./outputs/${SEED}

echo "${SEED}"

SatsumaSynteny2 -q data/${REF} -t data/${SEED} -o outputs/${SEED}

conda deactivate
