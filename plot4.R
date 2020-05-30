#Reading the data and subsetting it to get the data of the 1st and 2nd february 2007 

dt<-data.table::fread("My assignment/household_power_consumption.txt")
WantedDates<-grep(pattern = "^(1/2/2007)|^(2/2/2007)",dt[,Date])
consumption<-dt[WantedDates,]
consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
#Adding another column to be able to filter the data according to time of day 
consumption[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Creating plot 
png("plot4.png",width = 480,height=480)
par(mfrow=c(2,2))
plot(x = consumption$dateTime,y=consumption$Global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)",type = "l")

plot(x = consumption$dateTime,y=consumption$Voltage,xlab = "Datetime",ylab = "Voltage",type = "l")

plot(x = consumption$dateTime,y=consumption$Sub_metering_1,xlab = "",ylab = "Energy sub metering",type = "l" )
lines(consumption$dateTime,consumption$Sub_metering_2,col="red")
lines(consumption$dateTime,consumption$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1), lwd=c(1,1),col = c("black","red","blue"),legend = c("Sub metering 1","Sub metering 2","Sub metering 3"))

plot(x = consumption$dateTime,y=consumption$Global_reactive_power,xlab = "Datetime",ylab = "Global Reactive Power ",type = "l")

dev.off()

