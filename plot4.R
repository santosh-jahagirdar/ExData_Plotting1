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

#Change the layout to 2 rows and 2 columns
par(mfrow=c(2,2))

#Plot and save to png
plot(filtered_ds$DateTime,filtered_ds$Global_active_power,type="n",xlab="",ylab = "Global Active Power (kilowatts)")
lines(filtered_ds$DateTime,filtered_ds$Global_active_power)

plot(filtered_ds$DateTime,filtered_ds$Voltage,type="n",xlab="datetime",ylab = "Voltage")
lines(filtered_ds$DateTime,filtered_ds$Voltage)

plot(filtered_ds$DateTime,filtered_ds$Sub_metering_1,type="n",xlab="",ylab = "Energy sub metering")
lines(filtered_ds$DateTime,filtered_ds$Sub_metering_1)
lines(filtered_ds$DateTime,filtered_ds$Sub_metering_2, col="red")
lines(filtered_ds$DateTime,filtered_ds$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1), col = c("black","red","blue"), bty = "n",cex = 0.64,inset = 0.06)

plot(filtered_ds$DateTime,filtered_ds$Global_reactive_power,type="n",xlab="datetime",ylab = "Global_reactive_power")
lines(filtered_ds$DateTime,filtered_ds$Global_reactive_power)

dev.copy(png,"plot4.png",width = 480, height = 480, units = "px")
dev.off()

#Revert the layout to 1 row and 1 column
par(mfrow=c(1,1))




