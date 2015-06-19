extdata_proj2.r

setwd("~/Dropbox/Coursera.org/4_(Exploratory Data Analysis)/ Peer Assessments/Project_2/")

## REF:
#		https://github.com/rfoxfa/Exploratory_Data_Analysis/tree/master/Course%20Project%202
#		http://rstudio-pubs-static.s3.amazonaws.com/18781_2751400c28e14647a45032fc2a801e34.html


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

