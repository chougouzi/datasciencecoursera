#Dara Aalysis Case Study: Changes in Fine Particile Airr Pollution
##in the U.S.
#Very interesting case
#I hope oneday I can do such a wonderful case.
pm0 <- read.table("https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_1999-0.txt", 
                  comment.char = "#", header = FALSE, sep = "|", na.strings = "")
# First of all, we need to get familiar with those data.
dim(pm0)
head(pm0[, 1:13])
# Then, we need to attach the column headers to the dataset.
cnames <- readLines("https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_1999-0.txt", 1)
cnames <- strsplit(cnames, "|", fixed = TRUE)
# Strsplit(x, split, fixed = FALSE, perl = FALSE, useBytes = FALSE)
names(pm0) <-make.names(cnames[[1]])
# Make.names can change the space between two words into .
head(pm0[, 1:13])
# Then we can see the name of every variables
# We are interested in column Sample.Value, so we extract out it and print a brief summary.
x0 <- pm0$Sample.Value
summary(x0)
# Then we found some missing values. we check the proportion of the observations are missing
mean(is.na(x0))

# We read the 2012 data 
pm1 <- read.table("https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/CaseStudy/pm25_data/RD_501_88101_2012-0.txt", 
                  comment.char = "#", header = FALSE, sep = "|", na.strings = "")
# Set the names of column as we just did for 1999 datasets
names(pm1) <- make.names(cnames[[1]])
# Check the value of 2012
x1 <- pm1$Sample.Value


