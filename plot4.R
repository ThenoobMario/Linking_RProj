## Loading the libraries

library(ggplot2)


## Reading the required files

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
} 

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}


## Finding the SCC which have coal as a source 

coal <- grep("Coal", SCC$EI.Sector)

coal_SCC <- SCC[coal, ]


## Getting the NEI data with given SCC

req_data <- merge(NEI, coal_SCC, by = "SCC")


## Finding total emissions per year

t_emissions <- aggregate(Emissions ~ year, data = req_data, FUN = sum)


## Plotting the graph and saving it as a png file

png("plot4.png")

g <- ggplot(t_emissions, aes(factor(year), Emissions))

g <- g + geom_bar(stat = "identity", fill = "gray70") + xlab("Years") + 
     ylab(expression('Total PM'[2.5]*" Emissions")) + 
     ggtitle("Emissions from Coal combustion related sources")

print(g)

dev.off()