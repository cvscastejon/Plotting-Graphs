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
png("Plot4.png",width = 480, height = 480, units = "px")

#setting grid for the four plots
par(mfrow = c(2,2))

#Plotting four graphs
par(mfrow = c(2,2))
plot(household$Time, household$Global_active_power, type ="l", ylab = "Global Active Power", xlab = "", mar = c(1,1,1,1))
plot(household$Time, household$Voltage, type ="l", ylab = "Voltage", xlab = "datetime", mar = c(1,1,1,1))
plot(household$Time, household$Sub_metering_1, type ="l", ylab = "Energy sub metering", xlab = "", mar = c(1,1,1,1))
lines(household$Time, household$Sub_metering_2, type ="l", ylab = "Global Actvie Power (kilowatts)", xlab = "", col = "red")
lines(household$Time, household$Sub_metering_3, type ="l", ylab = "Global Actvie Power (kilowatts)", xlab = "", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
plot(household$Time, household$Global_reactive_power, type ="l", ylab = "Global Reactive Power", xlab = "datetime", mar = c(1,1,1,1))

#Close device
dev.off()