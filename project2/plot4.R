library("ggplot2")
NEI <- readRDS("R/eda/summarySCC_PM25.rds")
SCC <- readRDS("R/eda/Source_Classification_Code.rds")

if(!exists("NEI_SCC")){
  NEI_SCC <- merge(NEI, SCC, by="SCC")
}

coal  <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
newdata <- NEI_SCC[coal, ]


aggregatedDataByYear <- aggregate(Emissions ~ year, newdata, sum)

png("plot4.png", width=640, height=480)


g <- ggplot(aggregatedDataByYear, aes((year), Emissions))
g <- g + geom_line(position ="identity") +  xlab("year") +  ylab(expression("Total Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)


dev.off()