# Question 2:
# 	Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

unzip("exdata_data_NEI_data.zip", exdir="./Data", overwrite = T)  # unzip for data files
## -----------------------------------------------------------------------------

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Subsets data and appends two years in one data frame
MD <- subset(NEI, fips == '24510')

png(filename = 'plot2.png')
barplot(
	tapply(X = MD$Emissions, INDEX = MD$year, FUN = sum),
	main = "Total PM2.5 Emissions in Baltimore City, MD"
	xlab = 'Year',
	ylab = "PM2.5",
	col = rainbow(20, start = 0, end = 1)
	)
dev.off()

## -----------------------------------------------------------------------------
unlink("./Data", recursive = TRUE, force = TRUE)		## remove the data directory
