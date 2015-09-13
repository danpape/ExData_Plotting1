require ("sqldf")

# Only read lines from data file in current directory that correspond to the desired dates
data <- read.csv.sql("household_power_consumption.txt",
                       "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")
closeAllConnections()

# Create the plot as a png file in the current directory
png(filename = "plot1.png", width = 480, height = 480,  units = "px")
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
