require ("sqldf")

# Only read lines from data file in current directory that correspond to the desired dates
data <- read.csv.sql("household_power_consumption.txt",
                       "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")
closeAllConnections()

# Convert the Date and Time columns into a single datetime column
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Create the plot as a png file in the current directory
png(filename = "plot4.png", width = 480, height = 480,  units = "px")

# Make master plot have two rows and two columns
par(mfrow = c(2, 2))

# plot at (1,1)
plot(data$Datetime, data$Global_active_power, 
     type="l", ylab = "Global Active Power", xlab="")

# plot at (1,2)
with(data,plot(Datetime, Voltage, type="l"))

# plot at(2,1)
with(data, plot(Datetime, Sub_metering_1, type="l", col="black",
                  ylab = "Energy sub metering", xlab = ""))
with(data, lines(Datetime,Sub_metering_2, type="l", col="red"))
with(data, lines(Datetime,Sub_metering_3, type="l", col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), inset = .05, box.lty=0,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot at (2,2)
with(data,plot(Datetime, Global_reactive_power, type="l"))

dev.off()

