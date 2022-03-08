library(tidyverse)
library(data.table)
#Get clean and merged dataset
data <- fread("../../gen/output/calendar_holiday_distance_clean.csv.gz")

#Correlation matrix
library(Hmisc)
data %>%
  select(price, adjusted_price, dist_cs, Holiday) %>%
  as.matrix() %>%
  rcorr(type="spearman")

#Scatter plot on subset
pdf("../../gen/output/scatter_price_distance.pdf")
library(ggplot2)
data %>%
  slice_sample(n=10000) %>%
  ggplot(aes(dist_cs, price)) +
  geom_point() +
  geom_smooth(method="lm")

dev.off()

#Regression
summary(lm(price ~ dist_cs*Holiday, data))