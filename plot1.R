library(dplyr)
data <- read.table("household_power_consumption.txt",header = TRUE, sep =";",dec = ".",
                   na.strings=c("NA", "-", "?"),stringsAsFactors=F)
selectdata1 <- data[as.Date(data$Date,"%d/%m/%Y") == "2007-02-01",]
selectdata2 <- data[as.Date(data$Date,"%d/%m/%Y") == "2007-02-02",]
selectdata<-bind_rows(selectdata1,selectdata2)
png(file="plot1.png", width = 480, height = 480)
hist(as.numeric(selectdata$Global_active_power),main = "Global Active Power",
     xlab = "global active power (kilowatts)",
     xlim = c(0,6),
     col = "red")
dev.off