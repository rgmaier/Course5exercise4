library("ggplot2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting to factors
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

#Obtaining relevant SCC codes that relate to coal combustion
foo <- levels(SCC$EI.Sector)[grep("[cC]oal",levels(SCC$EI.Sector))]
sccLevel <- subset(SCC,EI.Sector %in% foo)

#Subset data to relevant levels
data <- subset(NEI,SCC %in%sccLevel$SCC)
data <- aggregate(data$Emissions, by=list(Year=data$year), FUN=sum)

#Creating the plot
png(file="plot4.png", bg="transparent", width=480, height=480, units="px")
plot(data$Year,data$x, type="p", xlab="Years",ylab="PM2.5 Emissions", main="PM2.5 Emissions per year from coal-combusition related sources")
dev.off()