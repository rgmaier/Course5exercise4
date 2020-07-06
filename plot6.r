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
data <- subset(NEI,SCC %in%sccLevel$SCC & (fips=="24510" | fips=="06037"))
data <- aggregate(data$Emissions, by=list(fips=data$fips, Year=data$year), FUN=sum)

#Creating the plot
png(file="plot6.png", bg="transparent", width=480, height=480, units="px")
qplot(Year,x,data=data)+
  facet_wrap(~fips,nrow=1)+
  labs(title = "Emissions per Year and Type for Baltimore City, MD and Los Angeles County, CA",
       subtitle="Los Angeles County, CA: 06037, Baltimore City, MD: 24510")+
  labs(y="PM2.5 emissions", x="Year")
dev.off()