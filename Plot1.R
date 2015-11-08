# Just read in first million records and see if it contains dates we want
hpc = read.table('C:/Users/Marc/Dropbox/Courera/exdata-data-household_power_consumption/household_power_consumption.txt',
                 skip=0, nrow=1000000, header=TRUE, sep=";")
tail(hpc) # it does
str(hpc) # examine the data frame
# Just get the two days we need
hpc = hpc[hpc$Date %in% c('1/2/2007','2/2/2007'),]
hpc$Global_active_power = as.character(hpc$Global_active_power)
hpc[hpc$Global_active_power=="?"] = NA
hpc$Global_active_power = as.numeric(hpc$Global_active_power)
head(hpc)
tail(hpc)
## Open png device; create 'Plot1.png' 
png(file = 'Plot1.png',width = 480, height = 480)
hist(hpc$Global_active_power,col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()