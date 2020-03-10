#!/bin/sh
#automate uploading script
#argv[1] pheno list made by countcase.sh
#argv[2] lowest amount of cases allowed 

#Split given list into chunks
chunk="500"
rm -f run*
cat ${1} | awk '{if($2 > '${2}'){print $0}}' > temp
split -l ${chunk} temp run
rm temp

mkdir -p script	

for i in $(ls run*)
do
   echo "${i}"
   #Wait untill there is you can upload 500+ scripts
   #Limit here is 2000
   while (( $(squeue --user ${USER} | wc -l) >= 1400 ))
   do
      squeue --user ${USER} | wc -l 
      echo "Nothing, Still on run ${i}, sleep"
      sleep 200
      echo 'checking again'
   done
   ./makeSLUM.sh ${i}
   echo "Genotype: On ${i}"
done 

echo 'DONE'
