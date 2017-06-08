library("data.table")

h_power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

h_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

h_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

h_power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

h_power <- h_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(h_power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

