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
plot(pwr_filt$Global_active_power~pwr_filt$DateTime
     , type = "l"
     , xlab = ""
     , ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()