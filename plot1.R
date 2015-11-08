# This program use library Lubridate
# importing the dataset
household<-read.csv("./household_power_consumption.txt", header=TRUE, sep=";")
#New variable Date1 with dmy format with the use of lubridate
household$Date1<-dmy(household$Date)
#Extracting the two dates with the use of lubridate
consumption_01<-household[household$Date1==dmy("01/02/2007"),]
consumption_02<-household[household$Date1==dmy("02/02/2007"),]
# The combined dataset for the two dates
fullset<-rbind(consumption_01,consumption_02)
# Making sure that the variable is numeric
fullset$Global_active_power<-as.character(fullset$Global_active_power)
fullset$Global_active_power<-as.numeric(fullset$Global_active_power)
# Saving the plot2 as a png format with size 480*480
png(file="./plot1.png",width=480,height=480)
#Histogram of Global active power with x label and and main title
hist(fullset$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main = "Global Active Power")
dev.off()