#!/bin/sh
#Will extract the top 100, 50, 10, 5, 3, and 1 
#argv[1] ID
#argv[2] out directory where all GWAS for ICD is 

#Check if theres any input
if [ -z "$2" ]; then
    echo "Please enter ID"
    exit
fi

dir="topN"
#make sure the dir is there
#mkdir -p ${dir}/ ${dir}/100 ${dir}/50 ${dir}/10 ${dir}/5 ${dir}/3 ${dir}/1

#assoc="${2}/${1}/${1}_--geno_0.1_--maf_0.01/${1}_--geno_0.1_--maf_0.01.assoc"

#awk '{if($1 != "CHR"){print $0}}' ${assoc} | sort -k9g | head -100 > ${dir}/100/${1} 
#awk '{if($1 != "CHR"){print $0}}' ${assoc} | sort -k10gr | head -100 > ${dir}/100/${1} 
#head -50  ${dir}/100/${1} > ${dir}/50/${1} 
#head -10  ${dir}/50/${1} > ${dir}/10/${1} 
#head -5   ${dir}/10/${1} > ${dir}/5/${1} 
#head -3   ${dir}/5/${1} > ${dir}/3/${1} 
head -1   ${dir}/3/${1} > ${dir}/1/${1} 

