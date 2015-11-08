# Just read in first million records and see if it contains dates we want
hpc = read.table('C:/Users/Marc/Dropbox/Courera/exdata-data-household_power_consumption/household_power_consumption.txt',
                 skip=0, nrow=1000000, header=TRUE, sep=";")
tail(hpc) # it does
str(hpc) # examine the data frame
# Just get the two days we need
hpc <- hpc[as.Date(hpc[,1], 
                   "%d/%m/%Y") == as.Date('2007-02-01') | as.Date(hpc[,1], 
                                                                  "%d/%m/%Y") == as.Date('2007-02-02'),]
hpc$Sub_metering_1 = as.character(hpc$Sub_metering_1)
hpc[hpc$Sub_metering_1=="?"] = NA
hpc$Sub_metering_1 = as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 = as.character(hpc$Sub_metering_2)
hpc[hpc$Sub_metering_2=="?"] = NA
hpc$Sub_metering_2 = as.numeric(hpc$Sub_metering_2)
head(hpc)
tail(hpc)
## Open png device; create 'Plot3.png' 
png(file = 'Plot3.png',width = 480, height = 480)
plot (c(0,1400),c(0,40),type="n", xaxt='n',
      yaxt='n', xlab="",ylab="Energy sub metering")
      lines(hpc$Time,hpc$Sub_metering_1,lwd=2.5)
      lines(hpc$Time,hpc$Sub_metering_2,col="red",lwd=2.5)
      lines(hpc$Time,hpc$Sub_metering_3,col="blue",lwd=2.5)
      legend(1000,40, c("Sub_metering_1",
                         "Sub_metering_2",
                         "Sub_metering_3"),
             lty=c(1,1,1),lwd=c(1,1,1),cex=c(.75,.75,.75),
             col=c("black","red","blue"))
      axis(1,at=c(0,700,1400), labels=c('Thur','Fri','Sat'))
# I couldn't figure out why my graph didn't match x range of example
dev.off()
