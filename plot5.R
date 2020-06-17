## Loading the libraries

library(ggplot2)


## Reading the required files

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
} 

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}


## Finding the SCC which has Onroad as a data category

motor_SCC <- subset(SCC, Data.Category == "Onroad")


## Subsetting NEI and getting required data

NEI_Baltimore <- subset(NEI, fips == "24510" )

req_data <- merge(NEI_Baltimore, motor_SCC, by = "SCC")

## Finding Total emissions per year

t_emissions <- aggregate(Emissions ~ year, data = req_data, sum)


## Plotting the graph and saving it as a png file

png("plot5.png", height = 500, width = 600)

g <- ggplot(t_emissions, aes(factor(year), Emissions))

g <- g + geom_bar(stat = "identity", fill = "gray70") + xlab("Years") + 
     ylab(expression('Total PM'[2.5]*" Emissions")) + 
     ggtitle("Total Emissions from motor vehicle sources in Baltimore City, Maryland over the years")

print(g)

dev.off()