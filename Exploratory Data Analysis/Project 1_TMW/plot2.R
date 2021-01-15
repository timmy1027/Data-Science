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
plot(dat1$DateTime, dat1$Global_active_power,
     type = "line",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()





