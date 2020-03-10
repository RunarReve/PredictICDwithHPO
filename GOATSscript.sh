#!/bin/sh
#Greatest Of All Time Second Script
#Script to automate run GWAS from pheno file to make manhattan plot .png
#Will take inn a pheno file name in directory pheno/

#Example ./GOATscript.sh G20 --maf 0.01 
#Will end up with with directory output/G20/G20_--maf_0.01/ with plinks assoc file 
# and a manhattan png file
#argv[1]  Pheno file and output
#argv[2+] plink settings
#---------------SETUP---------------

#Check if theres any input
if [ -z "$1" ]; then
    echo "Please input a pheno file!"
    exit
fi
echo "Start: "
date '+%A %W %Y %X'
pheno=$1    #Pheno file used
outFile=$1  #Output file name
plinkSet="" #Settings for plink

#Change these when moving this file around 
typeTitle="HPO" #TODO Part of title of plots (eg. plotFE or Genome)
bfile="/encrypted/e3001/maxat/alldata" #TODO Location of bfile to run GWAS on
phenodir="pheno"
rscripts="rScripts"


for var in "$@"  #Extract the options for plink from input
do 
    if [ "${var}" != "${1}" ]; then #Ignore the first args
 	plinkSet="$plinkSet $var"
        outFile="${outFile}_${var}"
    fi
done

if [ -z "$2" ]; then #If there is no settings selected, then add NULL to outFile
    outFile="${outFile}_NULL" 
fi

location="output/${pheno}/${outFile}/${outFile}"

tput setaf 1
echo ' '
echo "---------------------------------"
echo "Phenotype: $pheno"
echo "Plink setting: $plinkSet"
echo "Output file output: ${outFile}"
echo "Work directory: ${location}"
echo "---------------------------------"
echo ' '
tput sgr0

#-----------PLINK------------------

#PLINK Assoc 
module load plink
mkdir -p output/${pheno}/${outFile}
plink --bfile ${bfile} --assoc counts ${plinkSet} --pheno ${phenodir}/${pheno} --out ${location}

#-------------FILTER-OUT-P---------
#Set to remove every variant with p-val over 9e-8
awk '{if($1 == "CHR" || $9 < 9e-8){print $0}}' ${location}.assoc > ${location}.OR 
#-------------PLOTS-----------------
module load R
 
#Extract the lowest, non 0, P value, to use as Y limit in plot
lowestPVal=$(awk '{if( m== nulll || m > $9 && $9 != 0) {m = $9}  }  END{print m}' ${location}.assoc)
#Get amount of cases and contorls from the log (might differ a small bit from pheno)
stri="$(grep 'Among' ${location}.log | awk '{print "Cases: " $4"  Controls: " $8}')"

#Make png Manhattan Plot 
echo 'Manhattan'
Rscript ${rscripts}/manPlotPNG.r "${typeTitle}:${outFile}  ${stri}" ${location}.assoc ${lowestPVal}
#Move to easier find and change to a better name
if [ -d "./plots/manhattan/" ]; then 
   cp ${location}.assoc.png plots/manhattan/${outFile}.png
fi
mv ${location}.assoc.png ${location}.png

echo 'OR'
Rscript ${rscripts}/manORPlot.r "${typeTitle}:${outFile}  ${stri}" ${location}.OR 
if [ -d "./plots/OR/" ]; then 
   cp ${location}.OR.OR.png plots/OR/${outFile}.OR.png
fi
mv ${location}.OR.OR.png ${location}.OR.png

echo 'QQ'
Rscript ${rscripts}/qqplot.r "${typeTitle}:${outFile}  ${stri}" ${location}.assoc ${lowestPVal}
if [ -d "./plots/QQ/" ]; then 
   cp ${location}.assoc.QQ.png plots/QQ/${outFile}.QQ.png
fi
mv ${location}.assoc.QQ.png ${location}.QQ.png


#----------------DONE------------------
echo "End:"
date '+%A %W %Y %X'
echo "Done with: ${outFile}!" 
echo "---------------------------------"
echo ''
