## 1. get the raw data from the UCI website
## http://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
## record the date when the download happens
if(!file.exists("data")){dir.create("data")}
fileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl,destfile = "./data/hpc.zip")
datedownloaded <- date()
## 2. unzip this file
unzip("./data/hpc.zip", exdir = "./data")
myfile <- "./data/household_power_consumption.txt"
## 3. preprocess the raw data
rawdata <- read.csv(myfile,
                    sep=";",
                    na.strings = "?",
                    stringsAsFactors = F)
## 4. Perform the subsetting and date/time processing
data1 <- subset(rawdata,Date =="1/2/2007")
data2 <- subset(rawdata,Date =="2/2/2007")
data3 <- rbind(data1,data2)
data3$Time <- strptime(paste(data3$Date,data3$Time),
                       format="%d/%m/%Y %H:%M:%S")
data3$Date <- as.Date(data3$Date, 
                      format="%d/%m/%Y")

tidydata <- data3
## 5. writeup and store the tidy data
write.table(tidydata,"./data/tidydata.txt")
## 6. plot and explore
png(file = "plot1.png", width=480,height=480,units="px")
par(mar=c(4,4,1,1))
hist(tidydata$Global_active_power, 
     xlab="Global Active Power(kilowatts)",
     ylab="Frequency",
     col="red",
     main="Global Active Power")
dev.off()

