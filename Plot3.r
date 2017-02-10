setwd("C:/Users/marc.haserodt/Desktop/Exploratory data analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEIdata.zip")
unzip("NEIdata.zip")
summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

library(ggplot2)


summarySample <- summary[sample(nrow(summary), size=2000, replace=F), ]

# subset and factor	
MD <- subset(summary, fips == 24510)

# Generate and save as PNG
plot3 <- ggplot(MD,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title=expression("PM"[2.5]*" Emissions by Source"))
png(filename='Plot3.png', width=800, height=480, units='px')
plot(plot3)	
dev.off()

print(plot3)

#Question 3.
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
# All except "point" saw a decrease.  "Point" saw a very slight increase.