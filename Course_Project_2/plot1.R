# Question 1:
# 	Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.

unzip("exdata_data_NEI_data.zip", exdir="./Data", overwrite = T)  # unzip for data files
## -----------------------------------------------------------------------------

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")


# Aggregates
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = "Total Emission of PM2.5", xlab = "Year", ylab = "PM2.5 in Kilotons", col = rainbow(20, start = 0, end = 1))
dev.off()


## -----------------------------------------------------------------------------
unlink("./Data", recursive = TRUE, force = TRUE)		## remove the data directory
