#Kwabena Adu-Ababio, 16/11/2020
# This script extracts and combines two datasets from the UCI Machine Learning Repository 
# Install and load packages
library(dplyr)
library(ggplot2)
library(GGally)
library(tidyr)

# Metadata available at: http://hdr.undp.org/en/content/human-development-index-hdi
# Technical notes at : http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
#Read the “Human development” and “Gender inequality” data into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Explore the datasets
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

#rename the variables
colnames(hd)
hd <- 
  rename(hd ,
    ctry = Country ,
    hindex = Human.Development.Index..HDI. ,
    hrank = HDI.Rank,
    lfexp = Life.Expectancy.at.Birth ,
    expeduc = Expected.Years.of.Education ,
    meduc = Mean.Years.of.Education ,
    gni = Gross.National.Income..GNI..per.Capita ,
    gni.hdi = GNI.per.Capita.Rank.Minus.HDI.Rank ,
  )

colnames(gii)
gii <- 
  rename(gii,
    ctry = Country ,
    grank = GII.Rank ,
    gindex = Gender.Inequality.Index..GII.,
    mat.mort = Maternal.Mortality.Ratio ,
    ado.birth = Adolescent.Birth.Rate ,
    rep.parl = Percent.Representation.in.Parliament ,
    edu2F = Population.with.Secondary.Education..Female. ,
    edu2M = Population.with.Secondary.Education..Male. ,
    labF = Labour.Force.Participation.Rate..Female. ,
    labM = Labour.Force.Participation.Rate..Male. ,
  )

#Define new variables
gii <-  mutate(gii, edu2_rat=edu2F / edu2M) 
gii <-  mutate(gii, lab_rat=labF / labM)

#Joining datasets
join_by <- c("ctry")
hd_gii <- inner_join(hd, gii, by = join_by)
library(openxlsx)
write.xlsx(hd_gii,file="~/R/win-library/4.0/IODS-project/data/human.xlsx")

#Recall created data for check (195 observations and 19 variables)

human <- read.xlsx("~/R/win-library/4.0/IODS-project/data/human.xlsx")

#Continuation--23/11/2020
str(human)
dim(human)
names(human)
#This data  originates from the United Nations Development Programme. It measures the Human Development Index which was created to emphasize that people and their capabilities should be the ultimate criteria for assessing the development of a country, not economic growth alone. Variables have renamed as shown above.
library(stringr)
# Q1:Mutate the data
# look at the structure of the GNI column in 'human'
str(human$gni)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$gni, pattern=",", replace ="")%>%as.numeric(human$gni)

# Q2: Exclude unneeded variables
keep <- c("ctry", "edu2F", "labF", "expeduc", "lfexp", "gni", "mat.mort", "ado.birth", "rep.parl")
# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

#Q3: Remove rows with missing values
human <- filter(human, complete.cases(human))
str(human)

#Q4: Remove regions observations
# look at the last 10 observations
tail(human, 10)

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human<- human[1:last, ]

#Q5: Removing country variable
# add countries as rownames
rownames(human) <- human$ctry

# remove the Country variable
human <- select(human, -ctry)
dim(human)

#Saving new data with row names
write.xlsx(hd_gii,file="~/R/win-library/4.0/IODS-project/data/human.xlsx", rowNames = TRUE)

#Recall created data for check (195 observations and 19 variables)
human <- read.xlsx("~/R/win-library/4.0/IODS-project/data/human.xlsx")
