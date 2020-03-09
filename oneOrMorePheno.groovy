//A script to extract individuals with at least one phenotypes 
//Phenotypes is given in as parameters
//It will match sub-categories (eg. J0 will match J011, J091...) 
//eg. groovy oneMorePheno.groovy pheno S62 S52 
//Will extract individuals with S62 or S52 to pheno
//argv[1] morbid file to convert
//agrv[2] output pheno file 
//argv[3+] the ICD codes

//-----EXTRACT-ARGUMENTS-WANTED-BY-USER-----\\

def pheno = new String[args.size()] //Max phenotypes
for(i=2; i<pheno.size(); i++){
    pheno[i] = args[i]
    print(args[i])
}


//-----EXTRACT-PHENOTYPES-OUT-OF-FILE-----\\ 

file = args[0] //Morbid file with patient 
File outfile = new File(args[1])
new File(file).splitEachLine("\t"){ line ->
    if(checkLine(pheno, pheno.size(), line)){
	outfile << line[0] + '\t' + line[0] + "\t2\n"
	//println line[0] + '\t' + line[0] + "\t2"
    }else{
	outfile << line[0] + '\t' + line[0] + "\t1\n"
 	//println line[0] + '\t' + line[0] + "\t1" 
    }
}



/* Runs through all phenotypes selected on line
    Return true if at least one phenotype in line 
*/
boolean checkLine(String[] pheno, i, line){
    for(x = 0; x < i; x++){
        phenoCheck = pheno[x] //Easiest way to use an array in Regex 
	wordCheck = 1 //Skips the individuals ID  
	while(line[wordCheck] != null){ //Runs through every symptoms 
	    if(line[wordCheck] ==~ /$phenoCheck[0-9]*/) //Checks if the ICD is the same or a sub class
                return true
	    wordCheck++
	}
    }
    return false
}
