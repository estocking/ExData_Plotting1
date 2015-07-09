# Coursera: Exploratory Data Analysis
# Course Project #1

# Set working directory and pull in data zip file
setwd("C:/Desktop/Coursera/Exploratory Data Analysis")
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip")
  unzip("data.zip")  
}

# Read in and clean data
data <- read.csv("household_power_consumption.txt", 
                 skip=66637,
                 nrows=2880,
                 na.strings = "?",
                 header=F,
                 sep=";")
names(data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%y")
data$Time <- strptime(data$Time, format="%H:%M:%S")


## Plot #2
plot(data$DateTime, 
     data$Global_active_power, 
     type="l", 
     main="", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
