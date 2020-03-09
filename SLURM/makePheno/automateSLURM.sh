#!/bin/sh
#automate uploading script
#argv[1] the HPO 2 ICD list

mkdir -p script	
user="rever"
#Split the file
chunk="5"
N=$(wc -l ${1} | awk '{print $1}')
echo "${N}"
split -l ${chunk} ${1} run

for i in $(ls run*)
do
   echo "${i}"
   #Wait untill there is you can upload 500+ scripts
   #Limit here is 2000
   while (( $(squeue --user ${user} | wc -l) >= 1400 ))
   do
      squeue --user rever | wc -l 
      echo "Nothing, Still on run${i}, sleep"
      sleep 200
      echo 'checking again'
   done
   ./makeSLUM.sh ${i}
   echo "Genotype: On TEMP${i}"
done 

echo 'DONE'
