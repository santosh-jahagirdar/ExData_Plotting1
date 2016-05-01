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
plot(filtered_ds$DateTime,filtered_ds$Sub_metering_1,type="n",xlab = "datetime",ylab = "Energy sub metering")
lines(filtered_ds$DateTime,filtered_ds$Sub_metering_1)
lines(filtered_ds$DateTime,filtered_ds$Sub_metering_2, col="red")
lines(filtered_ds$DateTime,filtered_ds$Sub_metering_3, col="blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1), col = c("black","red","blue"))

dev.copy(png,"plot3.png",width = 480, height = 480, units = "px")
dev.off()





