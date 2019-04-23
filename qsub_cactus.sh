#!/bin/bash
#
#$ -N cactusAl_yeast
### -t 1-1
#$ -q pub8i
### -m beas
### -M craut@uci.edu
### -o
### -e
#$ -pe openmp 16

cactus jobStore yeast.txt outputs/yeast.hal --binariesMode local
