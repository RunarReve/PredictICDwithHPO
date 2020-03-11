#!/bin/sh

#Pheno list from ICDrunPlan
while IFS= read -r full
do
   line=$(echo ${full} | awk '{print $1}')
   echo $line
   cd script

   echo '#!/bin/bash' > ${line}.sh
   echo '#SBATCH --job-name=G'${line} >> ${line}.sh 
   echo '#SBATCH --time=03:00:00' >> ${line}.sh
   echo '#SBATCH --mem=100G' >> ${line}.sh 
   echo '#SBATCH --output='${line}'.err' >> ${line}.sh
   echo '' >> ${line}.sh
   echo 'cd ../../../' >> ${line}.sh

   echo '#Move to work directory' >> ${line}.sh
   echo 'rm    -f output/'${line} >> ${line}.sh
   echo 'mkdir -p output/'${line} >> ${line}.sh
   echo './GOATSscript.sh '${line} ' --geno 0.1 --maf 0.01' >> ${line}.sh
 
   chmod +x ${line}.sh   
   
   sbatch ${line}.sh

   cd ..

done < ${1}

