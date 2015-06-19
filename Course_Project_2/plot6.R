# Question 6:
# 	Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County,
# California (fips == "06037"). Which city has seen greater changes over time
# in motor vehicle emissions?

unzip("exdata_data_NEI_data.zip", exdir="./Data", overwrite = T)  # unzip for data files
## -----------------------------------------------------------------------------

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

library(ggplot2)

NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))


# Baltimore City, Maryland
# Los Angeles County, California
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregates
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep("Baltimore City, MD", 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by = list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep("Los Angeles County, CA", 4))

DF <- as.data.frame(rbind(MD.DF, CA.DF))

png('plot6.png')
g6 <- ggplot(data = DF, aes(x = year, y = Emissions, group=1)) +
	geom_bar(aes(fill = year), stat = "identity", alpha=0.5) +
	geom_line(aes(group = 1, size = 1, col = Emissions)) +
	geom_point(aes(size = 2, col = Emissions)) +
	guides(fill = F) +
	ggtitle("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008") +
	ylab( "PM2.5" ) +
	xlab( "Year" ) +
	theme(legend.position = 'none') +
	facet_grid(. ~ City) +
	geom_smooth(size = 2, color = "orange", linetype = 1, method = "lm", se = FALSE) +
	geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
plot(g6)
dev.off()



## -----------------------------------------------------------------------------
unlink("./Data", recursive = TRUE, force = TRUE)		## remove the data directory
