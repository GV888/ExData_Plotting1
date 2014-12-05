
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

par(mfcol = c(2, 2))

with(data, {
    plot(data$Global_active_power~data$FullDate, type="l", xlab="", ylab="Global Active Power")
  
    plot(data$Sub_metering_1~data$FullDate, type="l", xlab="", ylab="Energy sub metering")
    lines(data$Sub_metering_2~data$FullDate,col='Red')
    lines(data$Sub_metering_3~data$FullDate,col='Blue')
    legend("topright", lty=1, lwd=2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Voltage~FullDate, type="l", xlab="datetime", ylab="Voltage")
    
    plot(Global_reactive_power~FullDate, type="l", xlab="datetime", ylab="Global_reactive_power")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()