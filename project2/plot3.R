library("ggplot2")
if(!exists("NEI")){
  NEI <- readRDS("R/eda/summarySCC_PM25.rds")
}

myTransform <- function(data, years, types)
{  
  for (y in years) 
  {
      for (t in types) 
      {
        sumTemp <- sum(subset(data, year == y & fips == "24510" & type == t, select= c(Emissions))$Emissions)
        if(exists("newTypes")) {newTypes <- c(newTypes , t)} else {newTypes <- t}
        if(exists("emissions")) {emissions <- c(emissions , sumTemp)} else {emissions <- sumTemp}       
        if(exists("newYears")) {newYears <- c(newYears , y)} else {newYears <- y}        
      }      
  }  
  newdata <- data.frame(year = newYears, Emissions = emissions, type=newTypes)
}

Years <- c(1999, 2002, 2005, 2008)
types <- c("NON-ROAD", "NONPOINT", "ON-ROAD", "POINT")

newdata <- myTransform(NEI, Years, types)
qplot(year, Emissions, data = newdata, facets = . ~ type, geom = c("point", "smooth"), method = "lm")


dev.copy(png, file="R/eda/plot3.png", height=480, width=480)
dev.off()
