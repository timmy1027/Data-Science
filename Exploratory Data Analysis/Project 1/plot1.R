setwd("/Users/tianming1027/Documents/GitHub repository/Data-Science")

library("data.table")
#Reads in data from file then subsets data for specified dates
dat <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")


dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

dat1 <- as.data.frame(dat[dat$Date == "2007-02-01" | dat$Date == "2007-02-02",])
class(dat1$Global_active_power)

hist(dat1$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
