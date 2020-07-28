library(dplyr)
data <- read.table("household_power_consumption.txt",header = TRUE, 
                   sep =";",dec = ".",
                   na.strings=c("NA", "-", "?"),stringsAsFactors=F)
selectdata1 <- data[as.Date(data$Date,"%d/%m/%Y") == "2007-02-01",]
selectdata2 <- data[as.Date(data$Date,"%d/%m/%Y") == "2007-02-02",]
selectdata<-bind_rows(selectdata1,selectdata2)
selectdata<-selectdata[!is.na(selectdata),]
time <- as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time),
                              format="%d/%m/%Y %H:%M:%S"))
png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
## plot 1
plot(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                           format="%d/%m/%Y %H:%M:%S")),
     as.numeric(selectdata$Global_active_power),
     main = "",
     ylab = "global active power",
     xlab = "",
     xaxt = "n",
     type = "l",
     col = "black")
axis(1, at=c(time[1],floor((max(time,na.rm = TRUE)+time[1])/2),
             max(time,na.rm = TRUE)), labels=c("Thu","Fri", "Sat"))

## plot 2
plot(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                           format="%d/%m/%Y %H:%M:%S")),
     as.numeric(selectdata$Voltage),
     main = "",
     ylab = "voltage",
     xlab = "date time",
     xaxt = "n",
     type = "l",
     col = "black")
axis(1, at=c(time[1],floor((max(time,na.rm = TRUE)+time[1])/2),
             max(time,na.rm = TRUE)), labels=c("Thu","Fri", "Sat"))

## Plot 3
plot(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                           format="%d/%m/%Y %H:%M:%S")),
     as.numeric(selectdata$Sub_metering_1),
     main = "",
     ylab = "Energy Submeterring",
     xlab = "",
     xaxt = "n",
     type = "l",
     col = "black")
lines(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                            format="%d/%m/%Y %H:%M:%S")),
      as.numeric(selectdata$Sub_metering_2),
      col = "red")
lines(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                            format="%d/%m/%Y %H:%M:%S")),
      as.numeric(selectdata$Sub_metering_3),
      col = "blue")
axis(1, at=c(time[1],floor((max(time,na.rm = TRUE)+time[1])/2),
             max(time,na.rm = TRUE)), labels=c("Thu","Fri", "Sat"))
legend("topright",lty = c(1,1,1), legend=c("sub_metering_1",
                                           "sub_metering_2",
                                           "sub_metering_3"), 
       col=c("black","red","blue"))

## plot 4
plot(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                           format="%d/%m/%Y %H:%M:%S")),
     as.numeric(selectdata$Global_reactive_power),
     main = "",
     ylab = "Global_reactive_power",
     xlab = "date time",
     xaxt = "n",
     type = "l",
     col = "black")
axis(1, at=c(time[1],floor((max(time,na.rm = TRUE)+time[1])/2),
             max(time,na.rm = TRUE)), labels=c("Thu","Fri", "Sat"))
dev.off()