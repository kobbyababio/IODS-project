#Kwabena Adu-Ababio, 02/11/2020

# Install and load packages
install.packages ("dplyr")
install.packages ("ggplot2")
install.packages ("GGally")
library(dplyr)
library(ggplot2)
library(GGally)

#**Q2**: Reading in the data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Dimensions and structure of the data file
dim(lrn14)  
str(lrn14)
#Currently data file has 183 observations with 60 variables

#**Q3**: Data wrangling
# divide each number in a vector
c(1,2,3,4,5) / 2

# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude

# divide each number in the column vector
lrn14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# Create a new dataset
learning2014 <- select (lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

#After data wrangling dataset now has 166 observations with 7 variables
dim(learning2014)

#**Q4**: Set working directory, save then recal  data
setwd("~/R/win-library/4.0/IODS-project")

write.csv(learning2014, file = "learning2014.csv", row.names = FALSE)

read.csv("learning2014.csv")
str(learning2014)
head(learning2014)
