source("getdata.R")

consumption <- selectByDate(downloadData(), as.Date("2007-02-01"), as.Date("2007-02-02"))

png("plot4.png", width = 480, height = 480)

## save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")

## set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", "English")

## set up 2x2 plot area, adding plots by column->row order
par(mfcol = c(2, 2))

## 1st plot - the same as plot2.R
with(consumption, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

## 2nd plot - the same as plot3.R, except for legend box - it does not have a border
lineColors = c("black", "red", "blue")
with(consumption, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(consumption, points(Time, Sub_metering_1, type = "l", col = lineColors[1]))
with(consumption, points(Time, Sub_metering_2, type = "l", col = lineColors[2]))
with(consumption, points(Time, Sub_metering_3, type = "l", col = lineColors[3]))
legend("topright", lty = 1, bty = "n", col = lineColors, legend = names(consumption)[7:9])

## 3rd plot - Voltage over time
with(consumption, plot(Time, Voltage, type = "l", xlab = "datetime"))

## 4th plot - Global reactive power over time
with(consumption, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))

## restore system's original locale
Sys.setlocale("LC_TIME", locale)
dev.off()