library(ggplot2)

## Set working folder

setwd("~/GitHub/ExData_Project2/data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset for Baltimore and ON-ROAD
NEI24510_ONROAD <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

#Aggregate by year and convert to Kilotons
TOT_YR <- aggregate(Emissions ~ year, NEI24510_ONROAD, sum)

png("../plot5.png", width=640, height=480)
g <- ggplot(TOT_YR, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from 1999 to 2008 for: Baltimore, MD; ON-ROAD')
print(g)
dev.off()

