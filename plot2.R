#Load dplyr library to use mutuate function to add and modify columns to original dataset
library(dplyr)

#Load lubridate library to use date manipulation functions
library(lubridate)

#This is the path where I saved the unzipped data file
filepath <- "../../../Downloads/household_power_consumption.txt"

#Read the data file
ds <- read.table(filepath,header = TRUE,sep=";",na.strings="?")

#Convert the Date column's data type to Date
ds <- mutate(ds,Date=dmy(Date))

#Filter the dataset for the 2 days in consideration for the plots
filtered_ds <- subset(ds,Date==as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#Add a column to the dataset that includes the date as well as time
filtered_ds <- mutate(filtered_ds, DateTime = ymd_hms(paste(filtered_ds$Date, filtered_ds$Time)))

#Plot the lines and save it as png file
plot(filtered_ds$DateTime,filtered_ds$Global_active_power,type="n",xlab="",ylab = "Global Active Power (kilowatts)")
lines(filtered_ds$DateTime,filtered_ds$Global_active_power)

dev.copy(png,"plot2.png",width = 480, height = 480, units = "px")
dev.off()






