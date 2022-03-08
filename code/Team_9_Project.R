# Repository for Team 9 Data Preparation and Workflow Management

# Clear workspace
rm(list =ls())

#Import datasets
library(data.table)
library(tidyverse)


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
  select(price, adjusted_price, distance_to_the_centraal_station, Holiday) %>%
  as.matrix() %>%
  rcorr(type="spearman")

#Scatter plot between variables
#data %>% ggplot(aes(price, distance_to_the_centraal_station)) +
 # geom_point()

summary(lm(price ~ distance_to_the_centraal_station*Holiday, data))
