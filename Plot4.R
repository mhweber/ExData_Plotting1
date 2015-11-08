# Just read in first million records and see if it contains dates we want
hpc = read.table('C:/Users/Marc/Dropbox/Courera/exdata-data-household_power_consumption/household_power_consumption.txt',
                 skip=0, nrow=1000000, header=TRUE, sep=";")
tail(hpc) # it does
str(hpc) # examine the data frame
# Just get the two days we need
hpc <- hpc[as.Date(hpc[,1], 
                   "%d/%m/%Y") == as.Date('2007-02-01') | as.Date(hpc[,1], 
                                                                  "%d/%m/%Y") == as.Date('2007-02-02'),]
hpc$Date = as.Date(hpc$Date)
hpc$Global_active_power = as.character(hpc$Global_active_power)
hpc[hpc$Global_active_power=="?"] = NA
hpc$Global_active_power = as.numeric(hpc$Global_active_power)

hpc$Voltage = as.character(hpc$Voltage)
hpc[hpc$Voltage=="?"] = NA
hpc$Voltage = as.numeric(hpc$Voltage)

hpc$Global_reactive_power = as.character(hpc$Global_reactive_power)
hpc[hpc$Global_reactive_power=="?"] = NA
hpc$Global_reactive_power = as.numeric(hpc$Global_reactive_power)

hpc$Sub_metering_1 = as.character(hpc$Sub_metering_1)
hpc[hpc$Sub_metering_1=="?"] = NA
hpc$Sub_metering_1 = as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 = as.character(hpc$Sub_metering_2)
hpc[hpc$Sub_metering_2=="?"] = NA
hpc$Sub_metering_2 = as.numeric(hpc$Sub_metering_2)
head(hpc)
## Open png device; create 'Plot4.png' 
png(file = 'Plot4.png',width = 480, height = 480)
par(mfrow = c(2, 2))
plot(hpc$Global_active_power ~ hpc$Time, xaxt='n',type = "l",
     xlab="", ylab = "Global Active Power (kilowatts)")
axis(1,at=c(0,700,1400), labels=c('Thur','Fri','Sat'))

plot(hpc$Voltage ~ hpc$Time, xaxt='n',type = "l",
     xlab="", ylab = "Voltage")
axis(1,at=c(0,700,1400), labels=c('Thur','Fri','Sat'))

plot (c(0,1400),c(0,40),type="n", xaxt='n',
      yaxt='n', xlab="",ylab="Energy sub metering")
lines(hpc$Time,hpc$Sub_metering_1,lwd=2.5)
lines(hpc$Time,hpc$Sub_metering_2,col="red",lwd=2.5)
lines(hpc$Time,hpc$Sub_metering_3,col="blue",lwd=2.5)
legend(650,40, c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty=c(1,1,1),lwd=c(1,1,1),cex=c(.75,.75,.75),
       col=c("black","red","blue"))
axis(1,at=c(0,700,1400), labels=c('Thur','Fri','Sat'))

plot(hpc$Global_reactive_power ~ hpc$Time, xaxt='n',type = "l",
     xlab="", ylab = "Global_reactive_power")
axis(1,at=c(0,700,1400), labels=c('Thur','Fri','Sat'))
dev.off()