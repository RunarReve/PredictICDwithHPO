# PredictICDwithHPO
Method of converting ICD to HPO, then comparing the HPO with ICD



## Randomly split ICD morbid file
Split ICD randomly out of morbid file  (90/10 or 80/20)
Is by default set to removing 10% of ICDs, to change this just edit the TODO in randRmMor.py to ththe way you want it to be.

Input: 
   argv[1]: morbid file to remove
   argv[2]: new morbid out
Output:
   New morbid file
   Morbid file with only removed ICDs


# Convert ICD to HPO
Uses groovy script 'oneOrMorePheno.groovy' to make pheno files with each HPO and its mapped ICD

Input:
   argv[1]  The morbid file  to convert to pheno files
   argv[2]  Output pheno file (Normally HPO code here)
   agrv[3+] List of ICD connected to this output pheno file
Output:
   pheno file for plink in given directory

This can be a time consuming job, due to some HPO tend to have a lot of ICD under them (higher up in ontology the more it has to cover), might be possible to make this a lot quicker, but works for now. This is why we run all the pheno make on a cluster, for how we did this (on SLURM) se in directory SLURM/makePheno

./countcase.sh is a script that will count all the cases in the pheno files in pheno/.
Space seperating file formated: "ID, case, control, total"

# Run GWAS on HPO morbid 
TODO get GOATS/GOATSscript.sh and convert it to be more flexible 
./GOATscript.sh 
Is a script that sets up the plink settings and start the next script

./GOATSscript.sh 
Script that runs plink on given pheno file with given settings
Makes multiple plots from the GWAS (see output section below) 
Uses PLINK 1.90 and Rscript 

Input:
   argv[1]  Pheno file
   argv[2+] Settings for Plink to run GWAS
Output:
   In output directory/ phenofile/ plink settings:
     GWAS result from GWAS runned with Plink
     Manhattan plot (png)
     QQ plot (png)
     Manhattan plot with Odds ratio (png)
   All png will also be copied to plots/   


TODO make a SLURM for GWAS


# Merge HPO to recreate ICD

TODO get top N, all over x 

TODO remove unnecisary HPOs, that is just noise 

# Compare original GWAS with merged HPO GWAS

TODO Compare if the found variants is also in master GWAS
 
TODO Do some statistic, Jaccard, accurasy, or something 
