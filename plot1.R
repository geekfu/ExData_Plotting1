#use the sql to fetch the appropriate subset of data
library(sqldf)
if(!file.exists("data")){dir.create("data")}
#initialize source and sql statement
myfile <- "./data/household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
#get the data with seperator ';'
myData <- read.csv.sql(myfile,sql=mySql,sep=";")
#format the time and date
myData$Time <- strptime(paste(myData$Date,myData$Time),format="%d/%m/%Y %H:%M:%S")
myData$Date <- as.Date(myData$Date, format="%d/%m/%Y")
#define a file device to output
png(file = "plot1.png", width=480,height=480,units="px")
#draw the histogram with different attributes
par(mar=c(4,4,1,1))
hist(as.numeric(myData$Global_active_power[myData$Global_active_power!="?"]), 
     xlab="Global Active Power(kilowatts)",
     ylab="Frequency",
     col="red",
     main="Global Active Power")
#close the device
dev.off()