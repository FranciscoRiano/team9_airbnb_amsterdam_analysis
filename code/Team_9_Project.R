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

names(data)[names(data) == "distance_to_the_centraal_station "] <- "dist_cs"
summary(data)

#Correlation matrix
library(Hmisc)
data %>%
  select(price, adjusted_price, dist_cs, Holiday) %>%
  as.matrix() %>%
  rcorr(type="spearman")

#Scatter plot between variables
data %>% ggplot(aes(price, dist_cs)) +
  geom_point()