## Get assigned dataset
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
					  nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
	## Garbage collect
	rm(data_full)

## Convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Construct plot 1 with base plotting system.
hist(data$Global_active_power, main="Global Active Power", 
	 xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
