library(data.table)
#Reading the data and subsetting it to get the data of the 1st and 2nd february 2007 

dt<-data.table::fread("My assignment/household_power_consumption.txt")
WantedDates<-grep(pattern = "^(1/2/2007)|^(2/2/2007)",dt[,Date])
consumption<-dt[WantedDates,]
consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Creating the plot 

png("plot1.png",width = 480,height = 480)
hist(consumption$Global_active_power,main = "Global Active Power", col = "red",xlab = "Global Active Power (kilowatts) ")
dev.off()

