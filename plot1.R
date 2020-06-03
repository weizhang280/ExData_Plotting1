##plot1

##memory check
##The dataset has 2,075,259 rows and 9 columns
totalByte <- 2075259*9*8/2^20
##> totalByte
##[1] 142.4967
##The entire dataset requires about 143mb, plus overhead, the total memory needed would be 143mbx2 = 286mb

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

##generate histogram
hist(tabAll$Global_active_power, 
     col = 'red', 
     xlab = "Global Active Power (kilowatts)", 
     main="Global Active Power"
     )

##copy to png file
dev.copy(png, file="plot1.png")

##close png device, dev.off gives errors and fails to create png file when using along. 
##have to loop through and close all
while (!is.null(dev.list()))  dev.off()