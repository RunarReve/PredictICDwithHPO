#!/bin/sh
#automate uploading script
#argv[1] pheno list made by countcase.sh
#argv[2] lowest amount of cases allowed 

#wait untill SLURM is below
while (( $(squeue --user ${USER} | wc -l) >= 500 ))
do
   squeue --user ${USER} | wc -l 
   echo "Still not my turn, sleep   $(date)"
   sleep 600
   echo 'checking again'
done

cd ../../
./countcase.sh
cd SLURM/runGWAS

./automateSLURM.sh ../../phenolist 100 
