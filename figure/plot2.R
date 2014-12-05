
GetTimeStamp <- function(dates, times){
  x <- paste(dates, times)
  strptime(x, "%d/%m/%Y %H:%M:%S")
}


full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      skip=22000, nrows=50800, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')


data <- subset(power, GetTimeStamp(Date,Time) >= strptime("2007-02-01", "%Y-%m-%d") & GetTimeStamp(Date,Time) < strptime("2007-02-03", "%Y-%m-%d"))
rm(full)


fullDate <- paste(data$Date, data$Time)
data$FullDate <- as.POSIXct(strptime(fullDate, "%d/%m/%Y %H:%M:%S"))


plot(data$Global_active_power~data$FullDate, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()