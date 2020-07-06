NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting to factors
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

#Aggregating the data to obtain total levels per year
data <- aggregate(NEI$Emissions, by=list(Year=NEI$year), FUN=sum)

#Creating the plot
png(file="plot1.png", bg="transparent", width=480, height=480, units="px")
plot(data$Year,data$x, type="p", xlab="Years",ylab="PM2.5 Emissions")
dev.off()