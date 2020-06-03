##plot4

file <- "household_power_consumption.txt"

##get column classes for faster read of the large file
tab5rows <- read.table(file, header = TRUE, sep =";", nrow=5)
classes <- sapply(tab5rows, class)

##load data from the dates 2007-02-01 and 2007-02-02
tabAll <- read.table(file, col.names=names(tab5rows), sep =";", colClasses = classes, 
                     comment.char = "", na.strings="?", skip=66637, nrows=2880)

##Convert Date and Time columns from character to Date/Time classes
strDateTime <- paste(tabAll$Date, tabAll$Time)
tabAll$Time <- strptime(strDateTime, "%d/%m/%Y %H:%M:%S")
tabAll$Date <- as.Date(tabAll$Date, "%d/%m/%Y")

##multi plots
par(mfrow=c(2,2))

##plot1
plot(tabAll$Time, tabAll$Global_active_power, 
     type = "l", lty = 1, xlab = "", ylab = "Global Active Power")

##plot2
plot(tabAll$Time, tabAll$Voltage, 
     type = "l", lty = 1, xlab = "datetime", ylab = "Voltage")

##plot3
plot(tabAll$Time, tabAll$Sub_metering_1,
     type = "l", lty = 1, xlab = "", ylab = "Energy Sub Metering")
lines(tabAll$Time, tabAll$Sub_metering_2, type="l", lty=1, col="red", xlab="", ylab="")
lines(tabAll$Time, tabAll$Sub_metering_3, type="l", lty=1, col="blue", xlab="", ylab="")

##plot4
plot(tabAll$Time, tabAll$Global_reactive_power, 
     type = "l", lty = 1, xlab = "datetime", ylab = "Global_reactive_power")

##copy to png file
dev.copy(png, file="plot4.png")

##close png device, dev.off gives errors and fails to create png file when using along. 
##have to loop through and close all
while (!is.null(dev.list()))  dev.off()
