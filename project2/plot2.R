library("ggplot2")

if(!exists("NEI")){
  NEI <- readRDS("R/eda/summarySCC_PM25.rds")
}

sum99 <- sum(subset(NEI, year == 1999 & fips == "24510", select= c(Emissions))$Emissions)
sum02 <- sum(subset(NEI, year == 2002 & fips == "24510", select= c(Emissions))$Emissions)
sum05 <- sum(subset(NEI, year == 2005 & fips == "24510", select= c(Emissions))$Emissions)
sum08 <- sum(subset(NEI, year == 2008 & fips == "24510", select= c(Emissions))$Emissions)

Emissions <- c(sum99, sum02, sum05, sum08)
Years <- c(1999, 2002, 2005, 2008)

plot(Years, Emissions, type="l", col="red", lwd = 2, main="Maryland")
dev.copy(png, file="R/eda/plot2.png", height=480, width=480)
dev.off()
