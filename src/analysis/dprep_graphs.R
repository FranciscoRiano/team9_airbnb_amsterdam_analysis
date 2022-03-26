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