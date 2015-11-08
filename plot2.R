# This program use library Lubridate
# It was nessecary to add the encoding in order to get the english weekdays on plots
# Importing the full dataset
Sys.setlocale("LC_TIME","en_US.UTF-8")
household<-read.csv("./household_power_consumption.txt", header=TRUE, sep=";",encoding = "en_US.UTF-8")
household$Date1<-dmy(household$Date)

# extracting the the two dates. Here I have used the lubridate package
consumption_01<-household[household$Date1==dmy("01/02/2007"),]
consumption_02<-household[household$Date1==dmy("02/02/2007"),]
# The combined to dataset for the two dates
fullset<-rbind(consumption_01,consumption_02)
# New variable with both date and time
date_time<-strptime(paste(dmy(fullset$Date),fullset$Time),format="%Y-%m-%d %H:%M:%S")
# Adding the new variable data_time to the combined dataset
fullset<-cbind(date_time,fullset)
# Making sure that the variable is numeric
fullset$Global_active_power<-as.character(fullset$Global_active_power)
fullset$Global_active_power<-as.numeric(fullset$Global_active_power)
# Saving the plot as a png file with size 480*480
png(file="./plot2.png",width=480,height=480)
# Line plot of (x,y)=(data_time,Global_active_power)
plot(fullset$date_time,fullset$Global_active_power, type="l",ylab="Global Active Power (kilowatts)", xlab="")
dev.off()