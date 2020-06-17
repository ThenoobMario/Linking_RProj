## Reading the files 

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}


## Finding the total emission of PM2.5 per year

t_emissions <- with(NEI, tapply(Emissions, year, sum))

# Finding unique years

years <- unique(NEI$year)


## Plotting the graph and saving it as a png file

png("plot1.png")

plot(years, t_emissions, type = "l", lwd = 2, 
     xlab = "Years", ylab = "Total Emissions (In Tons)",
     main = expression("Total Emission of PM"[2.5]*" in the USA over the years"))

dev.off()