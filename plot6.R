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


## Subsetting NEI and getting the required data

NEI_Baltimore <- subset(NEI, fips == "24510")
NEI_LA <- subset(NEI, fips == "06037")

req_B <- merge(NEI_Baltimore, motor_SCC, by = "SCC")
req_LA <- merge(NEI_LA, motor_SCC, by = "SCC")


## Finding % change in  emissions per year

# Subtracting the value of Emission in the year 1999 from other years correspondingly

bt_emissions <- aggregate(Emissions ~ year + fips, data = req_B, sum)
bt_emissions$percent <- (bt_emissions$Emissions - 346.82)/346.82

lt_emissions <- aggregate(Emissions ~ year + fips, data = req_LA, sum)
lt_emissions$percent <- (lt_emissions$Emissions - 3931.120)/3931.120

# Combining both the Data frames 

t_emissions <- rbind(bt_emissions, lt_emissions)

# Changing the fips code to respective City name

t_emissions$fips[t_emissions$fips == "24510"] <- "Baltimore, Maryland" 
t_emissions$fips[t_emissions$fips == "06037"] <- "Los Angeles, California"


## Plotting the graph and saving it as a png file

png("plot6.png", width = 700)

g <- ggplot(data = t_emissions, aes(factor(year), percent))

g <- g + facet_grid(. ~ fips) + geom_bar(stat = "identity", fill = "sienna2") + 
     xlab("Years") + ylab("% change in total emissions") + 
     ggtitle(" Percentage change in Total Emissions from motor vehicle sources over the years",
             subtitle = "In Baltimore, Maryland and Los Angeles, California")

print(g)

dev.off()