#Kwabena Adu-Ababio, 30/11/2020
# This script extracts and combines two datasets from the the GitHub repository of MABS
# Install and load packages
library(dplyr) 
library(tidyr)
library(ggplot2)
library(GGally)
library(magrittr)

#Read the “BPRS” and “RATS” data into R
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#Explore the datasets
# Look at the (column) names of BPRS
names(BPRS)
names(RATS)

# Look at the structure of BPRS
str(BPRS)
str(RATS)
# Print out summaries of the variables
summary(BPRS)
summary(RATS)
glimpse(BPRS)
head(BPRS)
tail(BPRS)
glimpse(RATS)
head(RATS)
tail(RATS)

# Factor treatment & subject
BPRS <- within(BPRS, {
  treatment <- factor(treatment)
  subject <- factor(subject)
})

# Factor ID & Group
RATS <- within(RATS, {
  ID <- factor(ID)
  Group <- factor(Group)
})

glimpse(BPRS)
glimpse(RATS)

# Convert data to long form:
BPRSL <- gather(BPRS, key = weeks, value = bprs, week0:week8) %>% 
  mutate(week = as.integer(substr(weeks, 5, 5)))

RATSL <- gather(RATS, key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#Explore new data forms and compare to old form
glimpse(BPRSL)
glimpse(BPRS)
glimpse(RATSL)
glimpse(RATS)

#Saving new data
write.table(BPRSL,file="~/R/win-library/4.0/IODS-project/data/BPRSL.txt", sep  =" ", row.names = TRUE)
write.table(RATSL,file="~/R/win-library/4.0/IODS-project/data/RATSL.txt", row.names = TRUE, sep = '\t')

#Recall created data for check
read.table(file="~/R/win-library/4.0/IODS-project/data/BPRSL.txt", sep  =" ", header = T)
read.table(file="~/R/win-library/4.0/IODS-project/data/RATSL.txt", header = TRUE, sep = '\t')
