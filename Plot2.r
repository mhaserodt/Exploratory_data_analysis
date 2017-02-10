setwd("C:/Users/marc.haserodt/Desktop/Exploratory data analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEIdata.zip")
unzip("NEIdata.zip")
summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")


summarySample <- summary[sample(nrow(summary), size=5000, replace=F), ]

# Subset data to get 24510
MD <- subset(summary, fips=='24510')

# Generate plot and save as PNG

plot2 <- barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))
png(filename='Plot2.png')
plot(plot2)	
dev.off()

print(plot2)


#Question 2.
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
#After an increase in 2005, yes.