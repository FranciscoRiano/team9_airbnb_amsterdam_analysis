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
  slice_sample(n=1000000) %>%
  ggplot(aes(schiphol_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(tram_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(metro_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(cs_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(swim_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(religion_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(park_dist, price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(sport_dist, price)) +
  geom_smooth()

# Log transformed distances

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(schiphol_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(tram_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(metro_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(cs_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(swim_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(religion_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(park_dist), price)) +
  geom_smooth()

data %>%
  slice_sample(n=1000000) %>%
  ggplot(aes(log(sport_dist), price)) +
  geom_smooth()

#Plots of the number of infras in a 500 meter radius

data %>%
  slice_sample(n=100000) %>%
  ggplot(aes(metro_number_in_500, price)) +
  geom_col()

data %>%
  slice_sample(n=100000) %>%
  ggplot(aes(tram_number_in_500, price)) +
  geom_col()

data %>%
  slice_sample(n=100000) %>%
  ggplot(aes(swim_number_in_500, price)) +
  geom_col()

data %>%
  slice_sample(n=100000) %>%
  ggplot(aes(religion_number_in_500, price)) +
  geom_col()

data %>%
  slice_sample(n=100000) %>%
  ggplot(aes(park_number_in_500, price)) +
  geom_col()

data %>%
  slice_sample(n=100000) %>%
  ggplot(aes(sport_number_in_500, price)) +
  geom_col()

dev.off()

<<<<<<< HEAD
#Regression
=======
data$neighbourhood_cleansed <- as.factor(data$neighbourhood_cleansed)

#Regression model
>>>>>>> b5e158134855fef4d74cc340dfb963f4c79496e3
model_all_int_hol_wkend <- lm(price ~ .- date -listing_id -price - adjusted_price -longitude - latitude -Day -schiphol_number_in_500 + Weekend*metro_dist + Weekend*tram_dist + Weekend*schiphol_dist + Weekend*cs_dist + Holiday*metro_dist + Holiday*tram_dist + Holiday*cs_dist + Holiday*schiphol_dist, data,  na.action = na.omit)
summary(model_all_int_hol_wkend)

model_poly_log_int <- lm(price ~ log(tram_dist) + tram_number_in_500 + I(log(tram_dist)^2) +
                           log(metro_dist) + metro_number_in_500 + I(log(metro_dist)^2) +
                           log(cs_dist) + cs_number_in_500 + I(log(cs_dist)^2) +
                           log(swim_dist) + swim_number_in_500 + I(log(swim_dist)^2) +
                           log(religion_dist) + religion_number_in_500 + I(log(religion_dist)^2) +
                           log(park_dist) + park_number_in_500 + I(log(park_dist)^2) +
                           log(schiphol_dist)+ I(log(schiphol_dist)^2) +
                           log(sport_dist) + sport_number_in_500 + I(log(sport_dist)^2) +
                           Weekend*log(metro_dist) + Weekend*log(tram_dist) + Weekend*log(cs_dist) + Weekend*log(schiphol_dist) +
                           Holiday*log(metro_dist) + Holiday*log(tram_dist) + Holiday*log(cs_dist) + Holiday*log(schiphol_dist)
                           , data, na.action = na.omit)
summary(model_poly_log_int) # Should be including as.factor(neighbourhood_cleansed) but pc couldn't handle it haha


