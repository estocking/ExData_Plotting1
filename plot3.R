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


## Plot #3
yrange <- range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))
plot(data$DateTime, 
     data$Sub_metering_1, 
     ylim=yrange, 
     col="black", 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend('topright', names(data)[7:9], lty=1, col=c('black', 'red', 'blue'), bty='o')


dev.copy(png, "plot3.png", width=480, height=480)
dev.off()
