library(ggplot2)

## Set working folder

setwd("~/GitHub/ExData_Project2/data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset to Baltimore
NEI24510  <- NEI[NEI$fips=="24510", ]

#Aggregate by the Year and Type
TOT_YR_TYP <- aggregate(Emissions ~ year + type, NEI24510, sum)

png("../plot3.png", width=640, height=480)
g <- ggplot(TOT_YR_TYP, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ type)
g <- g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore, MD from 1999 to 2008')
print(g)
dev.off()