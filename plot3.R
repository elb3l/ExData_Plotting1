## You should find what is your Working directory?.. Use getwd()
## to change your Working directory. setwd("Path to your working directory")

##first step to obtain the raw data for the analysis
## if have manualy download & Extract the raw data skip this code snippet

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="hpc.zip")

## unzip the file
unzip("hpc.zip")
## if you doesn't work. do it manualy using any unzip programe you have.

## Make sure that extracted raw data in your working directory under folder "UCI HAR Dataset"

## using read.table to read our data in hpc data.frame
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",na.strings="?")
## converte the Date Character object to Date Object
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")
##create a logical filter for 1st & 2nd of feb 2007
Filter <- hpc$Date  == as.Date("2007-02-01") | hpc$Date  == as.Date("2007-02-02")
## filter our data and assinge it back to hpc
hpc <- hpc[Filter,]
## create a timespame vector and bind with column 3 to 9
Date_Time <- strptime(paste(hpc$Date, hpc$Time), "%Y-%m-%d %H:%M:%S")
hpc<-cbind(Date_Time,hpc[,3:9])

## remove any unnecessary data 
rm("Filter","Date_Time")


##Plot3
## seting general setting to graphics
par(mfrow = c(1, 1), mar = c(1.5, 4,1, 1), oma = c(1, 0.5, 0, 0), bg = "transparent")
## plot Sub_metering_1
plot( hpc$Date_Time , hpc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
## using points func to add Sub_metering_2 over Date_time plot 
points(hpc$Date_Time , hpc$Sub_metering_2, type = "l", col = "red")
## using points func to add Sub_metering_3 over Date_time plot 
points(hpc$Date_Time , hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright",cex=0.7, lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy my plot to a PNG file
##the default width is 480 and height is 480 see ?png
dev.copy(png, file = "plot3.png")
## close the PNG device!
dev.off() 


