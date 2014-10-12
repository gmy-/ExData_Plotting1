source("getdata.R")

consumption <- selectByDate(downloadData(), as.Date("2007-02-01"), as.Date("2007-02-02"))

png("plot1.png", width = 480, height = 480)
hist(consumption$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col = "red", main = "Global Active Power")
dev.off()