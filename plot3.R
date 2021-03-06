
library(tidyverse)


dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
File_name <- "household_power_consumption.txt"
Zip_name <- "exdata_data_household_power_consumption.zip" 
# if the data file doesn`t exist theh: if Zip file exist theh unzipped the file
# else `download and unzipped the file
if (!file.exists(File_name)){
  if(file.exists(Zip_name)){
    unzip(Zip_name)  
  }
  else{
    download.file(dataUrl, Zip_name)   
    unzip(Zip_name)
  }
} 
## Sys.setlocale("LC_TIME", "English") ## so that the dayes on the x-axis will be in English
# read the data to R
data_set <- read.table(File_name, header = TRUE, sep = ";", na.strings = "?",
                       colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric"))
data_set$Date <- as.POSIXct(paste(data_set$Date, data_set$Time, sep = " "), format="%d/%m/%Y %H:%M:%S")
data_set <- subset(data_set,Date >= "2007-02-01 00:00:00" & Date <= "2007-02-02 23:59:00")

png("plot3.png", width = 480, height = 480) # open Graphical device

plot(data_set$Date, data_set$Sub_metering_1, type = "n", xlab= "", ylab = "Energy sub metering")
lines(data_set$Date, data_set$Sub_metering_1) # col "black"
lines(data_set$Date, data_set$Sub_metering_2, col = "red")
lines(data_set$Date, data_set$Sub_metering_3, col = "blue")
legend("topright",lty = 1, lwd = 2 ,col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()


