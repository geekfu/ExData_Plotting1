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
png(file = "plot4.png", width=480,height=480,units="px")
#draw the curve with different attributes
par(mar=c(5,5,1,1),mfrow=c(2,2))
with(myData, {plot(Time, 
                  as.numeric(Global_active_power[Global_active_power!="?"]),
                  type="l",
                  xlab="",
                  ylab="Global Active Power")
              plot(Time, 
                   as.numeric(Voltage[Voltage!="?"]),
                   type="l",
                   xlab="datetime",
                   ylab="Voltage")
}
)
with(myData, plot(Time, 
                  as.numeric(Sub_metering_1[Sub_metering_1!="?"]),
                  type="l",
                  col="black",
                  xlab="",
                  ylab="Energy sub metering")
)

with(myData, lines(Time, 
                   as.numeric(Sub_metering_2[Sub_metering_2!="?"]),
                   col="red")
)

with(myData, lines(Time, 
                   as.numeric(Sub_metering_3[Sub_metering_3!="?"]),
                   col="blue")
)
legend("topright",
       lwd=2,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(myData, plot(Time, 
                   as.numeric(Global_reactive_power[Global_reactive_power!="?"]),
                   type="l",
                   xlab="datetime",
                   ylab="Global_reactive_power")
)

#close the device
dev.off()