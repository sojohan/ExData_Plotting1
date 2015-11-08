# This program use library lubridate
# importing the dataset with encoding US. 
Sys.setlocale("LC_TIME","en_US.UTF-8")
household<-read.csv("./household_power_consumption.txt", header=TRUE, sep=";",encoding = "en_US.UTF-8")
# New variable Date1 with dmy format using lubridate
household$Date1<-dmy(household$Date)

#Extrating the two dates
consumption_01<-household[household$Date1==dmy("01/02/2007"),]
consumption_02<-household[household$Date1==dmy("02/02/2007"),]
# The combined dataset of the two dates
fullset<-rbind(consumption_01,consumption_02)
# New variable data_time made by paste of Date and Time
date_time<-strptime(paste(dmy(fullset$Date),fullset$Time),format="%Y-%m-%d %H:%M:%S")
# Adding the date_time column to the combined dataset
fullset<-cbind(date_time,fullset)
# Making sure that the variables are numeric
fullset$Sub_metering_1<-as.character(fullset$Sub_metering_1)
fullset$Sub_metering_1<-as.numeric(fullset$Sub_metering_1)

fullset$Sub_metering_2<-as.character(fullset$Sub_metering_2)
fullset$Sub_metering_2<-as.numeric(fullset$Sub_metering_2)

fullset$Sub_metering_3<-as.character(fullset$Sub_metering_3)
fullset$Sub_metering_3<-as.numeric(fullset$Sub_metering_3)
# Saving the plot3 file as png with size 480*480
png(file="./plot3.png",width=480,height=480)
#plot of (x,y)=(date_time, Sub_metering_1)
plot(fullset$date_time,fullset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",col="black")
#adding Sub_metering_2
lines(fullset$date_time,fullset$Sub_metering_2, col="red")
#adding Submetering_3
lines(fullset$date_time,fullset$Sub_metering_3, col="blue")
#adding legend topright
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1,1,1),cex=0.6,col=c("black","red", "blue"))
dev.off()

