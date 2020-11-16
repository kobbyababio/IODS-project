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
