file <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                   na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

file$Date <- as.Date(file$Date, "%d/%m/%Y")

file <- subset(file,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

file <- file[complete.cases(file),]

dateTime <- paste(file$Date, file$Time)

dateTime <- setNames(dateTime, "DateTime")
file <- file[ ,!(names(file) %in% c("Date","Time"))]

file <- cbind(dateTime, file)

file$dateTime <- as.POSIXct(dateTime)

with(file, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()