#!/bin/sh

#Pheno list from ICDrunPlan
while IFS= read -r full
do
   line=$(echo ${full} | awk '{print $1}')
   rm ../../../pheno/${line}
   echo $line
   cd script

   echo '#!/bin/bash' > ${line}.sh
   echo '#SBATCH --job-name=G'${line} >> ${line}.sh 
   echo '#SBATCH --time=02:00:00' >> ${line}.sh
   echo '#SBATCH --mem=70G' >> ${line}.sh 
   echo '#SBATCH --output='${line}'.err' >> ${line}.sh
   echo '' >> ${line}.sh
   echo 'cd ../../../' >> ${line}.sh

   echo 'module load groovy' >> ${line}.sh
   echo 'groovy oneOrMorePheno.groovy '${full}  >> ${line}.sh
   
   chmod +x ${line}.sh   
   
   sbatch ${line}.sh

   cd ..

done < ${1}

