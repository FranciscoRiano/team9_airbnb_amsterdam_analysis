# Repository for Team 9 Data Preparation and Workflow Management

library(data.table)
library(R.utils)
listings <- fread("listings.csv.gz")
calendar <- fread("calendar.csv.gz")
reviews <- fread("reviews.csv.gz")
library(tidyverse)



# it is important to get the three files and en the setwd function we have to add the path where the 3 files are hosted
setwd()


library(data.table)
library(R.utils)
listings <- fread("listings.csv.gz")
calendar <- fread("calendar.csv.gz")
reviews <- fread("reviews.csv.gz")
library(tidyverse)

View(listings)
View(calendar)
View(reviews)


data <- reviews %>% left_join(listings, by = c("listing_id" = "id"), suffix = c("rev", "list")) %>%
  select(-ends_with("url"))

glimpse(data)

# review scores by neighbourhood, room type and property type
data$neighbourhood <- as.factor(data$neighbourhood)
data %>% group_by(neighbourhood) %>% summarize(mean(review_scores_rating))
data$room_type <- as.factor(data$room_type)
data %>% group_by(room_type) %>% summarize(mean(review_scores_rating))
data$property_type <- as.factor(data$property_type)
data %>% group_by(property_type) %>% summarize(mean(review_scores_rating))

# some graphs
library(ggplot2)

data$price <- as.numeric(gsub("\\$", "", data$price))

data %>% ggplot(aes(price, review_scores_rating)) +
  geom_point() +
  geom_smooth(method = "lm")

data %>% ggplot(aes(review_scores_rating)) +
  geom_histogram(bins = 10)

# Analyses

model1 <- lm(review_scores_rating ~ price, data); summary(model1)
model_2 <- lm(bedrooms ~ accommodates+room_type, listings)
summary(model_2)


# Descriptive statistics
summary(listings)
head(calendar)
summary(reviews)
summary(calendar)

