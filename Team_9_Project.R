# Repository for Team 9 Data Preparation and Workflow Management

library(data.table)
library(R.utils)
listings <- fread("listings.csv.gz")
calendar <- fread("calendar.csv.gz")
reviews <- fread("reviews.csv.gz")
library(tidyverse)

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