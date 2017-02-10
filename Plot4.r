setwd("C:/Users/marc.haserodt/Desktop/Exploratory data analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEIdata.zip")
unzip("NEIdata.zip")
summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

library(ggplot2)



# subset and merge
coal = source[grepl("coal", source$Short.Name, ignore.case=TRUE),]
merge <- merge(x=summary, y=coal, by='SCC')
mergeAgg <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(mergeAgg) <- c('Year', 'Emissions')


# Generate and save as PNG
plot4 <- ggplot(data=mergeAgg, aes(x=Year, y=Emissions/10^4)) + 
    geom_bar(stat="identity",fill="grey",width=0.75) + 
    theme_bw() +  guides(fill=FALSE) +
  	labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^4 Tons)")) + 
  	labs(title=expression("PM"[2.5]*" Coal Combustion Emissions"))
png(filename='Plot4.png')
plot(plot4)	
dev.off()

print(plot4)


#Question 4.
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Emissions have decreased by about a third.
