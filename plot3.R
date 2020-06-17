## Loading the required libraries 

library(ggplot2)


## Reading the required files

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
} 


## Subsetting the required Data

NEI_Baltimore <- subset(NEI, fips == "24510")


## Finding total emission per year and type

t_emissions <- aggregate(Emissions ~ year + type, data = NEI_Baltimore, FUN = sum)


## Plotting the graph and saving it as a png file

png(filename = "plot3.png")

g <- ggplot(t_emissions, aes(year, Emissions, color = type)) 

g <- g + geom_line() + xlab("Years") + ylab(expression('Total PM'[2.5]*" Emissions")) +
     ggtitle("Total Emissions in Baltimore City, Maryland over the years",
              subtitle = "Distinguised by type of source")

print(g)

dev.off()