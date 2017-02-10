setwd("C:/Users/marc.haserodt/Desktop/Exploratory data analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEIdata.zip")
unzip("NEIdata.zip")
summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

library(ggplot2)



# factoring
summary$year <- factor(summary$year, levels=c('1999', '2002', '2005', '2008'))

# subset data
mdOnroad <- subset(summary, fips == '24510' & type == 'ON-ROAD')
caOnroad <- subset(summary, fips == '06037' & type == 'ON-ROAD')

# Aggregate MD data
mdDF <- aggregate(mdOnroad[, 'Emissions'], by=list(mdOnroad$year), sum)
colnames(mdDF) <- c('year', 'Emissions')
mdDF$City <- paste(rep('MD', 4))

# Aggregate CA data
caDF <- aggregate(caOnroad[, 'Emissions'], by=list(caOnroad$year), sum)
colnames(caDF) <- c('year', 'Emissions')
caDF$City <- paste(rep('CA', 4))

#combine data
dataFrame <- as.data.frame(rbind(mdDF, caDF))

# Generate plot and save as PNG
plot6<-ggplot(data=dataFrame, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
    ggtitle('Total Vehicle Emissions\nLos Angeles County, CA vs. Baltimore City, MD') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
png(filename='Plot6.png')
plot(plot6)	
dev.off()

print(plot6)

#Question 6.
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?
#LA County has seen the largest change over time, however their emissions have actually increased since 1999.
