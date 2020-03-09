#!/bin/env/python
#Randomly removes x% of values in morbid files
#argv[1] in  morbid file
#argv[2] out morbid file
import sys
from random import randint


def main():
   dc=0
   c =0
   outfile = open(sys.argv[2], 'w')
   for line in open(sys.argv[1], 'r'):
     sline = line.split()
     for each in sline:
        if (each == sline[0]):
           out = [each]
           continue 
        c += 1
        #if random hit the wanted value, then remove it
        if(randint(1,10) == 1): 
           dc += 1 
        else:
           out.append(each)
     
     #print(randint(0,10))
     outfile.write("\t".join(out) + '\n')
   print(dc/c)

if __name__ == "__main__":
   main()
