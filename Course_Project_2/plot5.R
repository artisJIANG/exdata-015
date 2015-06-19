# Question 5:
# 	How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

unzip("exdata_data_NEI_data.zip", exdir="./Data", overwrite = T)  # unzip for data files
## -----------------------------------------------------------------------------

# Loads RDS
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

library(ggplot2)

NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregates
MD.df <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

png('plot5.png')
g2 <- ggplot(data = MD.df, aes(x = year, y = Emissions, , group=1)) +
	geom_bar(aes(fill = year), stat = "identity", alpha=0.5) +
	geom_line(aes(group = 1, size = 1, col = Emissions)) +
	geom_point(aes(size = 2, col = Emissions)) +
	guides(fill = F ) +
	ggtitle("Total Emissions of Motor Vehicle Sources in Baltimore City, MD") +
	ylab( "PM2.5" ) +
	xlab( "Year" ) +
	theme(legend.position = 'none') +
	geom_smooth(size = 2, color = "orange", linetype = 1, method = "lm", se = FALSE) +
	geom_text(aes(label = round(Emissions, 0), size = 2, hjust = 1, vjust = 3))
plot(g2)
dev.off()



## -----------------------------------------------------------------------------
unlink("./Data", recursive = TRUE, force = TRUE)		## remove the data directory
