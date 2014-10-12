source("getdata.R")

consumption <- selectByDate(downloadData(), as.Date("2007-02-01"), as.Date("2007-02-02"))

png("plot3.png", width = 480, height = 480)

## save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")

## set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", "English")

lineColors = c("black", "red", "blue")
with(consumption, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(consumption, points(Time, Sub_metering_1, type = "l", col = lineColors[1]))
with(consumption, points(Time, Sub_metering_2, type = "l", col = lineColors[2]))
with(consumption, points(Time, Sub_metering_3, type = "l", col = lineColors[3]))
legend("topright", lty = 1, col = lineColors, legend = names(consumption)[7:9])

## restore system's original locale
Sys.setlocale("LC_TIME", locale)
dev.off()