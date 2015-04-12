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
myfile<-select(newfile,-dt)
# first plot - histogram
hist(myfile$Global_active,xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",main="Global Active Power")
