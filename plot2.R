library(data.table)
#Reading the data and subsetting it to get the data of the 1st and 2nd february 2007 

dt<-data.table::fread("My assignment/household_power_consumption.txt")
WantedDates<-grep(pattern = "^(1/2/2007)|^(2/2/2007)",dt[,Date])
consumption<-dt[WantedDates,]
consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
#Adding another column to be able to filter the data according to time of day 
consumption[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Creating the plot
png("plot2.png",width = 480,height = 480)
plot(x = consumption$dateTime,y=consumption$Global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)",type = "l")
dev.off()
