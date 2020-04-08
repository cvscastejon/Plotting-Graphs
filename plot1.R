#date manipulaton done using lubridate package
library(lubridate)

#dataset reads entire table 
household <- read.table("household_power_consumption.txt", sep = ";", 
                        header = TRUE, colClasses = c("character", "character", "numeric", 
                                                      "numeric", "numeric", "numeric", "numeric", "numeric"), 
                        na.strings = "?")

#columns date and time are converted to Date class
household$Date <- dmy(household$Date)
household$Time <- hms(household$Time)

#subsetting to February First and Second of 2007
household <- household[(household$Date == ymd("2007-02-01") | household$Date == ymd("2007-02-02")),]

#open png device with required size
png("Plot1.png",width = 480, height = 480, units = "px")

#Generate histogram on specified device
hist(household$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     main = "Global Active Power")

#Close device
dev.off()