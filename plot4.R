# This program use library Lubridate
# Importing the full data set 
# It was nessecary to add the encoding in order to get the english weekdays on plots
Sys.setlocale("LC_TIME","en_US.UTF-8")
household<-read.csv("./household_power_consumption.txt", header=TRUE, sep=";",encoding = "en_US.UTF-8")
household$Date1<-dmy(household$Date)

# Extracting the two dates
consumption_01<-household[household$Date1==dmy("01/02/2007"),]
consumption_02<-household[household$Date1==dmy("02/02/2007"),]
# The combined data set for the two dates
fullset<-rbind(consumption_01,consumption_02)
# New variable data_time by pasting Date and Time 
date_time<-strptime(paste(dmy(fullset$Date),fullset$Time),format="%Y-%m-%d %H:%M:%S")
# Adding the new variable to the dataset
fullset<-cbind(date_time,fullset)
#Making sure that the variables are numeric
fullset$Global_active_power<-as.character(fullset$Global_active_power)
fullset$Global_active_power<-as.numeric(fullset$Global_active_power)
fullset$Sub_metering_1<-as.character(fullset$Sub_metering_1)
fullset$Sub_metering_1<-as.numeric(fullset$Sub_metering_1)

fullset$Sub_metering_2<-as.character(fullset$Sub_metering_2)
fullset$Sub_metering_2<-as.numeric(fullset$Sub_metering_2)

fullset$Sub_metering_3<-as.character(fullset$Sub_metering_3)
fullset$Sub_metering_3<-as.numeric(fullset$Sub_metering_3)
fullset$Voltage<-as.character(fullset$Voltage)
fullset$Voltage<-as.numeric(fullset$Voltage)

fullset$Global_reactive_power<-as.character(fullset$Global_reactive_power)
fullset$Global_reactive_power<-as.numeric(fullset$Global_reactive_power)

# Saving the file as png with size 480*480
png(file="./plot4.png",width=480,height=480)
par(mfrow=c(2,2))
# Here is the first plot in row 1. 
plot(fullset$date_time,fullset$Global_active_power, type="l",ylab="Global Active Power", xlab="")
# Here is the second plot in row 1. 
plot(fullset$date_time,fullset$Voltage, type="l",ylab="Voltage", xlab="datetime")

# Here is the first plot in row 2. 
plot(fullset$date_time,fullset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",col="black")

lines(fullset$date_time,fullset$Sub_metering_2, col="red")

lines(fullset$date_time,fullset$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1,1,1),cex=0.7,bty="n",col=c("black","red", "blue"))
# Here is the second plot in row 2. 
plot(fullset$date_time,fullset$Global_reactive_power, type="l",ylab="Global_reactive_power", xlab="datetime")

dev.off()