pwr_data<-read.table("household_power_consumption.txt",
                     sep = ";",
                     na.strings = "?",
                     header = TRUE)

#Filter records between 2007-02-01 and 2007-02-02
pwr_filt <- subset(pwr_data, pwr_data$Date == "1/2/2007" | pwr_data$Date == "2/2/2007")

#Convert Global_active_power field to numeric.
pwr_filt$Global_active_power<- as.numeric(as.character(pwr_filt$Global_active_power))

#Plot the graph
hist(pwr_filt$Global_active_power
     , col = "red"
     , type = "n"
     , xlab = "Global Active Power (kilowatts)"
     , ylab = "Frequency"
     , main = "Global Active Power"
    )
dev.copy(png, file = "plot1.png", height = 480, width = 480)

dev.off()
