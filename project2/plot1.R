library("ggplot2")

if(!exists("NEI")){
  NEI <- readRDS("R/eda/summarySCC_PM25.rds")
}

sum99 <- sum(subset(NEI, year == 1999, select= c(Emissions))$Emissions)
sum02 <- sum(subset(NEI, year == 2002, select= c(Emissions))$Emissions)
sum05 <- sum(subset(NEI, year == 2005, select= c(Emissions))$Emissions)
sum08 <- sum(subset(NEI, year == 2008, select= c(Emissions))$Emissions)

Emissions <- c(sum99, sum02, sum05, sum08)
Years <- c(1999, 2002, 2005, 2008)

plot(Years, Emissions, type="l", col="red", lwd = 2)
dev.copy(png, file="R/eda/plot1.png", height=480, width=480)
dev.off()
