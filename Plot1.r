setwd("C:/Users/marc.haserodt/Desktop/Exploratory data analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEIdata.zip")
unzip("NEIdata.zip")
summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")


summarySample <- summary[sample(nrow(summary), size=2000, replace=F), ]

# Aggregate data
Emissions <- aggregate(summary[, 'Emissions'], by=list(summary$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

# Generate and save as PNG

plot1 <- barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
png(filename='Plot1.png')
plot(plot1)	
dev.off()

print(plot1)

#Question 1.
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total
#PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#Yes.