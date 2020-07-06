library("ggplot2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting to factors
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

#Obtaining relevant SCC codes that relate to motor vehicles
foo <- levels(SCC$EI.Sector)[grep("On-Road",levels(SCC$EI.Sector))]
sccLevel <- subset(SCC,EI.Sector %in% foo)

#Subset data to relevant levels
data <- subset(NEI,SCC %in%sccLevel$SCC & fips=="24510")
data <- aggregate(data$Emissions, by=list(Year=data$year), FUN=sum)

#Creating the plot
png(file="plot5.png", bg="transparent", width=480, height=480, units="px")
plot(data$Year,data$x, type="p", xlab="Years",ylab="PM2.5 Emissions", main="PM2.5 Emissions per year from motor vehicles related sources")
dev.off()