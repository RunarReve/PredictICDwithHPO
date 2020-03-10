#!/bin/sh
#Greatest Of All Time Script
#Script to automate generate from morbid to make pdf
#Will take a maximum of 4 pheno innputs

#Example ./GOATscript.sh G20
#Will end up with with directory output/G20 with plinks assoc file 
# and a manhattan pdf file

#Check if theres any input
if [ -z "$1" ]; then
    echo "Please input pheno file!"
    exit
fi
pheno="${1}"
#Check if output dir is there
if [ -d "output" ]; then
   echo ''
else 
   echo "Creating output directory in currentt location"
   mkdir output
fi
rm -f output/${pheno}
mkdir output/${pheno}

#Start GOATSscript with standard input to make all files
./GOATSscript.sh ${pheno} --geno 0.1 --maf 0.01
