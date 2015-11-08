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
head(hpc)
tail(hpc)
## Open png device; create 'Plot2.png' 
png(file = 'Plot2.png',width = 480, height = 480)

plot(hpc$Global_active_power ~ hpc$Time, xaxt='n',type = "l",
     xlab="", ylab = "Global Active Power (kilowatts)")
axis(1,at=c(0,700,1400), labels=c('Thur','Fri','Sat'))
dev.off()
