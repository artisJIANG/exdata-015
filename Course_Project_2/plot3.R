# Question 3:
# 	Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions
# from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.


unzip("exdata_data_NEI_data.zip", exdir="./Data", overwrite = T)  # unzip for data files
## -----------------------------------------------------------------------------

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

library(ggplot2)

# Baltimore City, Maryland == fips
MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels = c('1999', '2002', '2005', '2008'))

## for bar chart
ggp <- ggplot(data = MD, aes( year, Emissions, fill=type, group=1)) +
	geom_bar(stat="identity")	+
	theme_bw()	+
	guides(fill=FALSE)	+
	facet_grid(. ~ type)	+
	labs(x="year", y=expression("Total PM2.5 Emission (Tons)"))	+
	labs(title="PM2.5 Emissions, Baltimore City 1999-2008 by Source Type") +
	geom_smooth(size = 2, color = "black", linetype = 1, method = "lm", se = FALSE)
print(ggp)



png(filename = 'plot3.png')
## for points and color scale
g2 <- ggplot( MD, aes(year, Emissions, group=1)) +
	geom_point(aes(color = type), size = 10, alpha = 0.3) +
	facet_grid(. ~ type, scales = "free") +
	theme_bw()	+
	geom_smooth(size = 2, color = "black", linetype = 1, method = "lm", se = FALSE)
print(g2)
dev.off()

## -----------------------------------------------------------------------------
unlink("./Data", recursive = TRUE, force = TRUE)		## remove the data directory
