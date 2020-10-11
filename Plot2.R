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

plot2<- plot(file$Global_active_power~file$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()