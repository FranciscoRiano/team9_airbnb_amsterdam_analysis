# Repository for Team 9 Data Preparation and Workflow Management

# Clear workspace
rm(list =ls())

# Make current directory the working directory. It is important to get the three files and en the setwd function we have to add the path where the 3 files are hosted
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))  

#Import datasets
library(data.table)
library(R.utils)
listings <- fread("listings.csv.gz")
calendar <- fread("calendar.csv.gz")
reviews <- fread("reviews.csv.gz")
library(tidyverse)

#View the datasets
View(listings)
View(calendar)
View(reviews)

#Merge the listings dataset with the reviews
data <- reviews %>% left_join(listings, by = c("listing_id" = "id"), suffix = c("rev", "list")) %>%
  select(-ends_with("url"))

glimpse(data)

#Too big: Error: cannot allocate vector of size 765.9 Mb
  #large_data <- data %>% left_join(calendar, by = "listing_id")

#Correlation matrix
library(corrplot)
data %>% select(starts_with("review_score"))%>%
  drop_na() %>%
  cor

# review scores by neighbourhood, room type and property type
data$neighbourhood <- as.factor(data$neighbourhood)
data %>% group_by(neighbourhood) %>% summarize(mean(review_scores_rating))
data$room_type <- as.factor(data$room_type)
data %>% group_by(room_type) %>% summarize(mean(review_scores_rating))
data$property_type <- as.factor(data$property_type)
data %>% group_by(property_type) %>% summarize(mean(review_scores_rating))

#Trying to avoid repition doesn't work
group_mean <- function(group, mean) {
  data %>% group_by(group) %>% summarize(mean(mean))
}

group_mean(property_type, review_scores_rating)

# some graphs
library(ggplot2)

data$price <- as.numeric(gsub("\\$", "", data$price))

data %>% ggplot(aes(price, review_scores_rating)) +
  geom_point() +
  geom_smooth(method = "lm")

data %>% ggplot(aes(review_scores_rating)) +
  geom_histogram(breaks = seq(0, 5, by = 0.1))

# Analyses

model1 <- lm(review_scores_rating ~ price, data); summary(model1)
model2 <- lm(bedrooms ~ accommodates+room_type, listings)
summary(model2)


# Descriptive statistics
summary(listings)
head(calendar)
summary(reviews)
summary(calendar)

