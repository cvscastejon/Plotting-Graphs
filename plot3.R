#date manipulaton done using lubridate package
library(lubridate)

#dataset reads entire table 
household <- read.table("household_power_consumption.txt", sep = ";", 
                        header = TRUE, colClasses = c("character", "character", "numeric", 
                                                      "numeric", "numeric", "numeric", "numeric", "numeric"), 
                        na.strings = "?")

#columns date is converted to Date class
household$Date <- dmy(household$Date)

#subsetting to February First and Second of 2007
household <- household[household$Date == ymd("2007-02-01") | household$Date == ymd("2007-02-02"),]

#combine date and time in second column
household$Time <- ymd_hms(paste(household$Date,household$Time))

#open png device with required size
png("Plot3.png",width = 480, height = 480, units = "px")

#plot line graph 
plot(household$Time, household$Sub_metering_1, type ="l", ylab = "Energy sub metering", xlab = "")

#adding additional lines
lines(household$Time, household$Sub_metering_2, type ="l", ylab = "Global Actvie Power (kilowatts)", xlab = "", col = "red")
lines(household$Time, household$Sub_metering_3, type ="l", ylab = "Global Actvie Power (kilowatts)", xlab = "", col = "blue")

#adding legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

#Close device
dev.off()