source('~/Google Drive/Training/Data Science/Exploratory Data/Project1/Proj1.R')
# the data - https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# set working directory and read in the file
setwd("~/Google Drive/Training/Data Science/Exploratory Data/Project1")
hpcfile <- read.csv("~/Google Drive/Training/Data Science/Exploratory Data/Project1/household_power_consumption.txt", sep=";", na.strings="?", nrows=2075300,stringsAsFactors=FALSE,row.names=NULL)
# load lubridate and dplyr
library(lubridate)
library(dplyr)
# convert the Date columns to Date/Time format and subset the data frame to the dates needed
hpcfile$Date<-as.Date(strptime(hpcfile$Date,"%d/%m/%Y"))
newfile<-hpcfile[hpcfile$Date%in%as.Date(c("2007-02-01","2007-02-02")),]
# create a new date-time variable in date format
newfile$dt<-paste(newfile$Date,newfile$Time)
newfile$dt2<-ymd_hms(newfile$dt)
myfile2<-select(newfile,-dt)
# third plot - line plot of sub_metering observations grouped by weekday of Global Active Power readings
## tidy the data by gathering the sub metering variables
myfile3<-gather(myfile2,submeter,submeterval,-Date,-Time,-Global_active_power,-Global_reactive_power,-Voltage,-Global_intensity,-dt2)
# create the successive plots w colors
plot(myfile3$dt2,myfile3$submeterval,type="n",xlab="",ylab="Energy sub metering")
lines(myfile3$dt2[myfile3$submeter=="Sub_metering_1"],myfile3$submeterval[myfile3$submeter=="Sub_metering_1"],col="black",type="l")
lines(myfile3$dt2[myfile3$submeter=="Sub_metering_2"],myfile3$submeterval[myfile3$submeter=="Sub_metering_2"],col="red",type="l")
lines(myfile3$dt2[myfile3$submeter=="Sub_metering_3"],myfile3$submeterval[myfile3$submeter=="Sub_metering_3"],col="blue",type="l")
# add the legend
temp <- legend("topright", legend = c(" ", " "," "),
               text.width = strwidth("Sub_metering_1"),col=c("black","red","blue"),
               lty = 1, xjust = 1, yjust = 0)
text(temp$rect$left + temp$rect$w, temp$text$y,
     c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), pos = 2)
