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


#Plot the graphs

#Set the screen to accomodate 4 graphs
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

#Graph1
with(pwr_filt, plot(Global_active_power ~ DateTime,
                    type = "l",
                    ylab = "Global Active Power",
                    xlab = ""))
#Graph2
with(pwr_filt, plot(Voltage ~ DateTime,
                    type = "l",
                    ylab = "Voltage"))
#Graph3
with(pwr_filt, plot(Sub_metering_1 ~DateTime,
                    type = "l",
                    xlab = "",
                    ylab = "Energy sub metering"))
lines(Sub_metering_2 ~ DateTime, pwr_filt, col = "red")
lines(Sub_metering_3 ~ DateTime, pwr_filt, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       lty = 1,
       lwd = 2,
       cex = 0.4,
       bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Graph4
with(pwr_filt, plot(Global_reactive_power ~ DateTime, 
                    type = "l"))

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()