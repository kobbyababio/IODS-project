#Kwabena Adu-Ababio, 30/11/2020
# This script extracts and combines two datasets from the the GitHub repository of MABS
# Install and load packages
library(dplyr) 
library(ggplot2)
library(GGally)
library(tidyr)
library(magrittr)

#Read the “BPRS” and “RATS” data into R
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep = '\t')

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#Explore the datasets

