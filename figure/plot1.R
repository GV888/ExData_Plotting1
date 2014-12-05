power <- read.csv("household_power_consumption.txt", sep=";", skip=22000, nrows=50800, 
                  colClasses = c("character", "character", "numeric", 
                                 "numeric", "numeric", "numeric"
                                 , "numeric", "numeric", "numeric"),
                  col.names = c("Date","Time", "Global_active_power", "Global_reactive_power",
                                "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                  na.strings = c("?")
                  )
#head(power)

GetTimeStamp <- function(dates, times){
  x <- paste(dates, times)
  strptime(x, "%d/%m/%Y %H:%M:%S")
}

TStamp <- function(dates){
  x <- c(dates)
  strptime(x, "%Y-%m-%d")
}


newdata <- subset(power, GetTimeStamp(Date,Time) >= TStamp("2007-02-01") & GetTimeStamp(Date,Time) < TStamp("2007-02-03"))
#View(newdata)

hist(newdata$Global_active_power, col = "red", breaks = 20, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png,'plot1.png', height=480, width=480)
dev.off()