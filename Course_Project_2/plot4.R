# Question 4:
# 	Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

unzip("exdata_data_NEI_data.zip", exdir="./Data", overwrite = T)  # unzip for data files
## -----------------------------------------------------------------------------

# Loads RDS
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

library(ggplot2)

# Coal-related SCC
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merges two data sets
merge <- merge(x = NEI, y = SCC.coal, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

png(filename = 'plot4.png')
g2 <- ggplot(data = merge.sum, aes(x = Year, y = (Emissions / 1000)) ) +
	geom_bar( stat="identity", fill="grey", width=0.75 ) +
	geom_line(aes(group = 1, size=2, col = Emissions)) +
	geom_point(aes(size = 3, col = Emissions)) +
	ggtitle( "Coal Combustion-Related Source Emissions" ) +
	ylab( "PM2.5 in kiloTons" ) +
	geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = -0.1, vjust = -0.5)) +
	theme(legend.position = 'none') +
	scale_colour_gradient(low = 'black', high = 'blue')
print(g2)
dev.off()

## -----------------------------------------------------------------------------
unlink("./Data", recursive = TRUE, force = TRUE)		## remove the data directory
