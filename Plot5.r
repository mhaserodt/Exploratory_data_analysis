setwd("C:/Users/marc.haserodt/Desktop/Exploratory data analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEIdata.zip")
unzip("NEIdata.zip")
summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

library(ggplot2)



# factoring
summary$year <- factor(summary$year, levels=c('1999', '2002', '2005', '2008'))

# subset data
mdOnroad <- subset(summary, fips == 24510 & type == 'ON-ROAD')

# Aggregate
mdData <- aggregate(mdOnroad[, 'Emissions'], by=list(mdOnroad$year), sum)
colnames(mdData) <- c('year', 'Emissions')

# Generate plot and save as PNG
plot5<-ggplot(mdData,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*"Vehicle Emissions in Baltimore"))	
png(filename='Plot5.png')
plot(plot5)	
dev.off()

print(plot5)

#Question 5.
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#
