## Joseph W. Grubbs, Ph.D., AICP, GISP
## Coursera Data Science Specialization
## Exploratory Data Analysis - Course 4
## Peer-Reviewed Project - Week 1
## Source: plot1.R

## Download source data and execute ETL functions
filename <- "household_power_consumption.zip"

if (!file.exists(filename)) {
  fileURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(fileURL, filename, method = "curl")
}  
if (!file.exists("UCI Household Power Consumption")) { 
  unzip(filename) 
}

## Load library for data.table package
library(data.table)

## Use fread() to handle large source data set
plotTemp <- fread("household_power_consumption.txt", 
                  header = TRUE, sep = ";", 
                  na.strings = "?",
                  data.table = TRUE)

## Convert "Date" "Time" vars from character class; paste() "DateTime"
plotData <- plotTemp[, Date1 := as.IDate(plotTemp$Date, "%d/%m/%Y")]
plotData <- plotData[, Time1 := as.ITime(plotData$Time, "%H:%M:%S")]
plotData <- plotData[, DateTime := as.POSIXct(paste(plotData$Date1, 
                                              plotData$Time1), 
                                              format = "%Y-%m-%d %H:%M:%S")]

## Subset data into date range defined for project sample
dtPlot <- plotData[Date1 %between% c("2007-02-01", "2007-02-02")]

## Generate "plot1" using R base plotting system
with(dtPlot, hist(Global_active_power, 
                    xlab = "Global Active Power (kilowatts)", 
                    col = "red", 
                    main = "Global Active Power"))

## Copy "plot1" from screen device to PNG file w=480px h=480px
dev.copy(png, file = "plot1.png",
              width = 480, 
              height = 480,
              units = "px")

## Turn off PNG graphics device
dev.off()
