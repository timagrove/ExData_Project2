library(ggplot2)
library(dplyr)

## Set working folder

setwd("~/GitHub/ExData_Project2/data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Join NEI and SCC
NEI_SCC <- left_join(NEI,SCC)

# Subset for coal only
coal_TF  <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
NEI_SCC <- NEI_SCC[coal_TF, ]

#Aggregate by year and convert to Kilotons
TOT_YR <- aggregate(Emissions ~ year, NEI_SCC, sum)
TOT_YR$Emissions <- round(TOT_YR[, 2] / 1000, 2)

png("../plot4.png", width=640, height=480)
g <- ggplot(TOT_YR, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions in Kilotons")) +
  ggtitle('Total Emissions from Coal sources from 1999 to 2008')
print(g)
dev.off()

