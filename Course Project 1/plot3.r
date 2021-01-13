pwr_data<-read.table("household_power_consumption.txt",
                     sep = ";",
                     na.strings = "?",
                     header = TRUE)

#Filter records between 2007-02-01 and 2007-02-02
pwr_filt <- subset(pwr_data, pwr_data$Date == "1/2/2007" | pwr_data$Date == "2/2/2007")

#Convert Global_active_power field to numeric.
pwr_filt$Global_active_power<- as.numeric(as.character(pwr_filt$Global_active_power))

#Derive DateTime from Date and Time fields.
pwr_filt$DateTime<- as.POSIXct(paste(pwr_filt$Date, pwr_filt$Time),  format = "%d/%m/%Y %H:%M:%S")


#Plot the graph
with(pwr_filt, plot(Sub_metering_1~DateTime,
                    type = "l",
                    xlab = "",
                    ylab = "Energy sub metering"))
lines(Sub_metering_2 ~ DateTime, pwr_filt, col = 'Red')
lines(Sub_metering_3 ~ DateTime, pwr_filt, col = 'Blue')

legend("topright", col = c("black", "red", "blue"),
       lty = 1,
       lwd = 2,
       cex = 0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()