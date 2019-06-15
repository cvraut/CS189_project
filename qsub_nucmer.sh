
#!/bin/bash
#
#$ -N nucmer
#$ -t 1-4
#$ -q pub8i
## ckpt restart
### -m beas
### -M beoungl@uci.edu
### -o
### -e
#$ -pe openmp 8-32

conda activate cg_yeast

echo "Running nucmer"

REF=$(cat nucmer.ls | head -n 1)
SEED=$(cat nucmer.ls | head -n $((${SGE_TASK_ID}+1)) | tail -n 1)
##SEED=${SEED%%.*}


echo "$((${SGE_TASK+ID}+1))"
echo "$(REF)"
echo "${SEED}"

nucmer --maxmatch -c 100 -p ${SEED} ${REF} ${SEED}
mummerplot --png --fat --layout --filter ${SEED}.delta -R ${REF} -Q ${SEED} --prefix=${SEED}

conda deactivate


