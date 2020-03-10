#!/bin/sh
#Get list of numbers of patients with each HPO

rm -f list
touch list

for line in $(ls pheno)
do
   echo "${line}"
   awk '{tot= tot+1; if($3 == '2' ){sum = sum + 1}else{cont=cont+1}}
      END{print "'${line}' "sum " "cont" "tot}' pheno/${line} >> list 
done 

sort -k2 -nr list > phenolist
rm list

