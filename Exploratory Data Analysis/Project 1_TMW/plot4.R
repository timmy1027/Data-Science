setwd("/Users/tianming1027/Documents/GitHub repository/Data-Science")

library("data.table")
#Reads in data from file then subsets data for specified dates
dat <- data.table::fread(input = "household_power_consumption.txt"
                         , na.strings="?")


dat$Date <- as.Date(dat$Date, "%d/%m/%Y")


dat1 <- as.data.frame(dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",])
dat1$DateTime <- with(dat1, paste(Date, Time))
dat1$DateTime <- strptime(dat1$DateTime, "%Y-%m-%d %H:%M:%S")
class(dat1$DateTime)

par(mfrow = c(2,2))
#plot4-1
plot(dat1$DateTime, dat1$Global_active_power,
     type = "line",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
#plot4-2
plot(dat1$DateTime, dat1$Voltage,
     type = "line",
     ylab = "Voltage",
     xlab = "datetime")
#plot4-3
plot(dat1$DateTime, dat1$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dat1$DateTime, dat1$Sub_metering_2, col = "red")
lines(dat1$DateTime, dat1$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1, cex = 0.5)
#plot4-4
plot(dat1$DateTime, dat1$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
