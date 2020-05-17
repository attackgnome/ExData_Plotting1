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

#Create plot2
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

plot(data$date_time, data$Global_active_power, type = "l", lty = 1, main="",
     xlab="", ylab = "Global Active Power (kilowatts)")

dev.off()