#Kwabena Adu-Ababio, 02/11/2020

#Q2: Reading in the data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Dimensions and structure of the data file
dim(lrn14)
str(lrn14)