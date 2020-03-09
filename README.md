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

This can be a time consuming job, due to some HPO tend to have a lot of ICD under them (higher up in ontology the more it has to cover) that is why we run all the pheno make on a cluster, for how we did this (on SLURM) se in directory SLURM/makePheno

# Run GWAS on HPO morbid 


# Merge HPO to recreate ICD


# Compare original GWAS with merged HPO GWAS
