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

## Construct plot 2 with base plotting system.
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save to PNG file with width=480 pixels and height=480 pixels.
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
