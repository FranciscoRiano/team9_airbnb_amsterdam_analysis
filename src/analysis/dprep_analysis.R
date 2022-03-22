library(tidyverse)
library(data.table)
#Get clean and merged dataset
data <- fread("../../gen/output/calendar_holiday_distance_clean.csv.gz")

#Correlation matrix
library(Hmisc)
data %>%
  select(price, adjusted_price, cs_dist, Holiday) %>%
  as.matrix() %>%
  rcorr(type="spearman")

#Scatter plot on subset
pdf("../../gen/output/scatter_price_distance.pdf")
library(ggplot2)
data %>%
  slice_sample(n=10000) %>%
  ggplot(aes(cs_dist, price)) +
  geom_point() +
  geom_smooth(method="loess")

data %>%
  slice_sample(n=10000) %>%
  ggplot(aes(schiphol_dist, price)) +
  geom_point() +
  geom_smooth(method="loess")

data %>%
  slice_sample(n=10000) %>%
  ggplot(aes(log(religion_dist), price)) +
  geom_point() +
  geom_smooth(method="loess")

data %>%
  slice_sample(n=10000) %>%
  ggplot(aes(metro_dist, price)) +
  geom_point() +
  geom_smooth(method="loess")

dev.off()

data$neighbourhood_cleansed <- as.factor(data$neighbourhood_cleansed)

#Regression model
model_all_int_hol_wkend <- lm(price ~ .- date -listing_id -price - adjusted_price -longitude - latitude -Day -schiphol_number_in_500 + Weekend*metro_dist + Weekend*tram_dist + Weekend*schiphol_dist + Weekend*cs_dist + Holiday*metro_dist + Holiday*tram_dist + Holiday*cs_dist + Holiday*schiphol_dist, data,  na.action = na.omit)
summary(model_all_int_hol_wkend)
