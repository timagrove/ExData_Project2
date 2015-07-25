library(ggplot2)

## Set working folder

setwd("~/GitHub/ExData_Project2/data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset for Baltimore, Los Angeles, and ON-ROAD
NEI_BALT_LA_ONROAD <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

# Aggregate the data and replace the fips number with the city name
TOT_YR <- aggregate(Emissions ~ year + fips, NEI_BALT_LA_ONROAD, sum)
TOT_YR$fips[TOT_YR$fips=="24510"] <- "Baltimore, MD"
TOT_YR$fips[TOT_YR$fips=="06037"] <- "Los Angeles, CA"

png("../plot6.png", width=640, height=480)
g <- ggplot(TOT_YR, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from 1999-2008 for:\nBaltimore City, MD vs Los Angeles, CA; ON-ROAD')
print(g)
dev.off()

