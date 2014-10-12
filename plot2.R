source("getdata.R")

consumption <- selectByDate(downloadData(), as.Date("2007-02-01"), as.Date("2007-02-02"))

png("plot2.png", width = 480, height = 480)

## save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")

## set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", "English")

with(consumption, plot(Time, Global_active_power, type = "l",
                       xlab = "", ylab = "Global Active Power (kilowatts)"))

## restore system's original locale
Sys.setlocale("LC_TIME", locale)
dev.off()

