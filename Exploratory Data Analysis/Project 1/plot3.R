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

plot(dat1$DateTime, dat1$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dat1$DateTime, dat1$Sub_metering_2, col = "red")
lines(dat1$DateTime, dat1$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1)
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
