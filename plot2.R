require ("sqldf")

# Only read lines from data file in current directory that correspond to the desired dates
data <- read.csv.sql("household_power_consumption.txt",
                       "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")
closeAllConnections()

# Convert the Date and Time columns into a single datetime column
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Create the plot as a png file in the current directory
png(filename = "plot2.png", width = 480, height = 480,  units = "px")
plot(data$Datetime, data$Global_active_power,  
     type="l", ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()
