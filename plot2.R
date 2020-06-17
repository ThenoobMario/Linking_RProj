## Reading the files

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}


## Subsetting the required Data 

NEI_Baltimore <- subset(NEI, fips == "24510")


## Finding total emission per year

t_emissions <- with(NEI_Baltimore, tapply(Emissions, year, sum))

# Finding unique years

years <- unique(NEI$year)


## Plotting the graph and saving it as a png file

png("plot2.png")

plot(years, t_emissions, type = "l", lwd = 2,
     xlab = "Years", ylab = "Total Emission (In Tons)",
     main = expression("Total Emission of PM"[2.5]*" in Baltimore City, Maryland over the years"))

dev.off()