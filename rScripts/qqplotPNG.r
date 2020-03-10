#Simple manhattan plot with lables to top SNPs 
#Will output a png plot 

#'qqman' package needs to be installed
#(install.packages("qqman")
library(qqman)

#Able to read given arguments
#args[1]:Title name for the plot
args <- commandArgs(trailing = TRUE)

title <- args[1]
location <- args[2]

#Tell R that output should be .png 
png(paste(location, ".png", sep=""), width = 900 , height = 900,  res = 90)

#Load in the table to
theTable <- read.table(location, header = TRUE) 

#Plot the table into (X=Chromosone possition, Y=log P value)
qq(theTable$P, main = title)
