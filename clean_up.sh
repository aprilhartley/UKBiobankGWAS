#!/bin/bash

#SBATCH -p mrcieu2,mrcieu
#SBATCH --nodes=1 --tasks-per-node=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=3-00:00:00

SLURM_SUBMIT_DIR="/mnt/storage/private/mrcieu/research/UKBIOBANK_GWAS_Pipeline/data/phenotypes/ah14433/output"

cd $SLURM_SUBMIT_DIR/$SUBDIR/$FILENAME
#$SUBDIR=subdirectory for results in output folder (e.g. /ASTHMA/588af769-189c-4d90-b942-fdc31c59867a) 
cat <(cat *chr22*.glm.logistic | head -n1) <(for i in *chr*.glm.logistic; do cat $i | awk "FNR>1" | awk "NR==1 || /ADD/"; done) > temp
mv temp $FILENAME"_imputed.txt"
sed -i 's/#//g' $FILENAME"_imputed.txt"
gzip  $FILENAME"_imputed.txt"

