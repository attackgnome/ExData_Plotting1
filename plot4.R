##Download Data and read in data table
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=';', header = TRUE, 
                   stringsAsFactors=FALSE, na.strings = "?")
unlink(temp)

##Convert the `Date` field from factor to POSIXlt. Filter `data` to `Date` equal to "2007-02-01" or "2007-02-02"
data$Date <- as.Date(strptime(data$Date,  format = "%d/%m/%Y")) 
data <- subset(data, Date == "2007-02-01"| Date == "2007-02-02")
data$date_time <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

#Create plot4
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

old_options <- par(mfrow = c(2, 2))
plot(data$date_time, data$Global_active_power, type = "l", lty = 1, main="",
     xlab="", ylab = "Global Active Power")
plot(data$date_time, data$Voltage, type = "l", lty = 1, main="",
     xlab="datetime", ylab = "Voltage")

plot(data$date_time, data$Sub_metering_1, type = "l", lty = 1, main="",
     xlab="", ylab = "Energy sub metering")
lines(data$date_time, data$Sub_metering_2, col = "red", type = "l", lty = 1)
lines(data$date_time, data$Sub_metering_3, col = "blue", type = "l", lty = 1)

# Add a legend to the plot
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1, cex=0.8)


plot(data$date_time, data$Global_reactive_power, type = "l", lty = 1, main="",
     xlab="datetime", ylab = "Global_reactive_power")

dev.off()