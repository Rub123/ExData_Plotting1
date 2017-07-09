
library(tidyverse)
library(lubridate)

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
# read the data to R
data_set <- read.table(File_name, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?",
                       colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric"))
data_set$Date <- dmy(data_set$Date) # use lubridate::dmy to convert the Dates from "character" to "Date"
data_set <- filter(data_set,Date >= "2007-02-01",Date <= "2007-02-02")


png("plot1.png", width = 480, height = 480)  # open Graphical device
with(data_set,
     hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatt)"))
dev.off()
