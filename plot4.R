library("data.table")


h_power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

h_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

h_power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

h_power <- h_power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(h_power[, dateTime], h_power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(h_power[, dateTime],h_power[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(h_power[, dateTime], h_power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(h_power[, dateTime], h_power[, Sub_metering_2], col="red")
lines(h_power[, dateTime], h_power[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(h_power[, dateTime], h_power[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()