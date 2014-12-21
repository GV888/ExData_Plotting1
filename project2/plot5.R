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
}


aggregatedDataByYear <- aggregate(Emissions ~ year, Baltimore, sum)

png("plot5.png", width=640, height=480)

g <- ggplot(aggregatedDataByYear, aes((year), Emissions))
g <- g + geom_line(position ="identity") +  xlab("year") +  ylab(expression("Emissions")) +
  ggtitle('Total Emissions from motor vehicle sources from 1999 to 2008 from Baltimore City')
print(g)

dev.off()