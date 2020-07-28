library(dplyr)
data <- read.table("household_power_consumption.txt",header = TRUE, sep =";",dec = ".",
                   na.strings=c("NA", "-", "?"),stringsAsFactors=F)
selectdata1 <- data[as.Date(data$Date,"%d/%m/%Y") == "2007-02-01",]
selectdata2 <- data[as.Date(data$Date,"%d/%m/%Y") == "2007-02-02",]
selectdata<-bind_rows(selectdata1,selectdata2)
selectdata<-selectdata[!is.na(selectdata),]
time <- as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                              format="%d/%m/%Y %H:%M:%S"))
png(file="plot2.png", width = 480, height = 480)
plot(as.numeric(as.POSIXct(paste(selectdata$Date, selectdata$Time), 
                           format="%d/%m/%Y %H:%M:%S")),
     as.numeric(selectdata$Global_active_power),
     main = "",
     ylab = "global active power (kilowatts)",
     xlab = "",
     xaxt = "n",
     type = "l",
     col = "black")
axis(1, at=c(time[1],floor((max(time,na.rm = TRUE)+time[1])/2),
             max(time,na.rm = TRUE)), labels=c("Thu","Fri", "Sat"))
dev.off()