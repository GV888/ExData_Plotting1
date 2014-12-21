library("ggplot2")

if(!exists("NEI")){
  NEI <- readRDS("R/eda/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("R/eda/Source_Classification_Code.rds")
}

if(!exists("NEI_SCC")){
  NEI_SCC <- merge(NEI, SCC, by="SCC")
}

if(!exists("vehicles")){
  vehicles  <- grepl("Vehicles", NEI_SCC$EI.Sector, ignore.case=TRUE)  
  vehiclesdata <- NEI_SCC[vehicles, ]
  
  Baltimore <- vehiclesdata[NEI_SCC$fips == "24510", ]
  California  <- vehiclesdata[NEI_SCC$fips == "06037", ]  
}


aggregatedDataBaltimore <- aggregate(Emissions ~ year, Baltimore, sum)
aggregatedDataCalifornia <- aggregate(Emissions ~ year, California, sum)

aggregatedDataBaltimore$fips <- "24510"
aggregatedDataCalifornia$fips <- "06037"

aggregatedData <- rbind(aggregatedDataBaltimore, aggregatedDataCalifornia)



plot(aggregatedData$year, aggregatedData$Emissions, xlab="Years", ylab="Emissions", main="Vehicle Emissions in Baltimore vs. LA")
lines(aggregatedDataBaltimore$year, aggregatedDataBaltimore$Emissions, col="red", lwd=2)
lines(aggregatedDataCalifornia$year, aggregatedDataCalifornia$Emissions, col="green", lwd=2)

legend("topright", lty=1, lwd=2, col = c("red", "green"), legend = c("Baltimore City", "Los Angeles County"))


dev.copy(png, file="plot6.png", height=553, width=861)
dev.off()