#!/bin/bash
#
#$ -N cactus_yeast_script
#$ -t 1        ## task ids
#$ -q pub8i      ## queue to send task to
#$ -ckpt restart ## include to make sure tasks are suspended & checkpointed
### -m beas
### -M craut@uci.edu
### -o
### -e
#$ -pe openmp 1  ## multiple nodes, integer is # of cores

source ~/.miniconda3rc
cd /pub/{$USER}/CS189_project
conda --version
conda activate cg_yeast
## cactus -h
rm -rf jobStore

cactus jobStore yeast.txt outputs/yeast.hal --binariesMode local

conda deactivate
