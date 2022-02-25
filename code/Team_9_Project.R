# Repository for Team 9 Data Preparation and Workflow Management

# Clear workspace
rm(list =ls())

#Import datasets
library(data.table)
library(tidyverse)

#Get data
data <- fread("../data/calendar_holiday_distance.csv.gz")
View(data)

#Data inspection
dim(data)
glimpse(data)
summary(data)

#Cleaning data
data$price <- as.numeric(gsub("\\$", "", data$price))
data$adjusted_price <- as.numeric(gsub("\\$", "", data$adjusted_price))

