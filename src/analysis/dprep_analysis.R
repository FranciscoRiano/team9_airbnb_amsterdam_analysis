library(tidyverse)
library(data.table)
#Get clean and merged dataset
data <- fread("../../gen/output/calendar_holiday_distance_clean.csv.gz")


#Plot distance variables all in one plot
library(reshape2)
library(ggplot2)
long_data <- melt(data %>% select(price, ends_with("_dist")), id="price")

pdf("../../gen/output/scatter_price_distance.pdf")

#Distance on price
long_data %>%
  slice_sample(n=1000000) %>% 
  ggplot(aes(value, price, colour = variable)) +
  geom_smooth(se=F)

#Log distance on price
long_data %>%
  slice_sample(n=1000000) %>% 
  ggplot(aes(log(value), price, colour = variable)) +
  geom_smooth(se=F)

#Plots of the number of infras in a 500 meter radius
s_size <- 10000
data %>%
  slice_sample(n=s_size) %>% 
  drop_na() %>%
  group_by(metro_number_in_500) %>%
  summarize(price = mean(price), count = n()) %>% 
  ggplot(aes(metro_number_in_500, price)) +
  geom_col() +
  geom_text(aes(y = price + 10, label=paste("n=", count)), vjust=0)

data %>%
  slice_sample(n=s_size) %>% 
  drop_na() %>%
  group_by(tram_number_in_500) %>%
  summarize(price = mean(price), count = n()) %>% 
  ggplot(aes(tram_number_in_500, price)) +
  geom_col() +
  geom_text(aes(y = price + 10, label=paste("n=", count)), vjust=0)

data %>%
  slice_sample(n=s_size) %>% 
  drop_na() %>%
  group_by(cs_number_in_500) %>%
  summarize(price = mean(price), count = n()) %>% 
  ggplot(aes(cs_in_500, price)) +
  geom_col() +
  geom_text(aes(y = price + 10, label=paste("n=", count)), vjust=0)

data %>%
  slice_sample(n=s_size) %>% 
  drop_na() %>%
  group_by(religion_number_in_500) %>%
  summarize(price = mean(price), count = n()) %>% 
  ggplot(aes(religion_number_in_500, price)) +
  geom_col() +
  geom_text(aes(y = price + 10, label=paste("n=", count)), vjust=0)

data %>%
  slice_sample(n=s_size) %>% 
  drop_na() %>%
  group_by(park_number_in_500) %>%
  summarize(price = mean(price), count = n()) %>% 
  ggplot(aes(park_number_in_500, price)) +
  geom_col() +
  geom_text(aes(y = price + 10, label=paste("n=", count)), vjust=0)

data %>%
  slice_sample(n=s_size) %>% 
  drop_na() %>%
  group_by(sport_number_in_500) %>%
  summarize(price = mean(price), count = n()) %>% 
  ggplot(aes(sport_number_in_500, price)) +
  geom_col() +
  geom_text(aes(y = price + 10, label=paste("n=", count)), vjust=0, size=2)

dev.off()

#Regression
data$neighbourhood_cleansed <- as.factor(data$neighbourhood_cleansed)

#Regression model
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
                           Holiday*log(metro_dist) + Holiday*log(tram_dist) + Holiday*log(cs_dist) + Holiday*log(schiphol_dist) +
                           neighbourhood_cleansed
                         , data, na.action = na.omit)
summary(model_poly_log_int)

#Save output in csv
library(broom)
write.csv(tidy(model_all_int_hol_wkend) , "../../gen/output/model_all_int_hol_wkend.csv")
write.csv(tidy(model_poly_log_int) , "../../gen/output/model_poly_log_int.csv")

