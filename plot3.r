library("ggplot2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting to factors
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

#Aggregating the data to obtain total levels per year for Baltimore City, MD
data <- subset(NEI, fips=="24510")
data <- aggregate(data$Emissions, by=list(type=data$type, Year=data$year), FUN=sum)

#Creating the plot
png(file="plot3.png", bg="transparent", width=480, height=480, units="px")
qplot(Year,x,data=data)+facet_wrap(~type,nrow=1)+ggtitle("Emissions per Year and Type for Baltimore City, MD")+labs(y="PM2.5 emissions", x="Year")
dev.off()