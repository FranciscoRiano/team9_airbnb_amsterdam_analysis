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
  geom_smooth(method="lm")

dev.off()

#Regression
summary(lm(price ~ cs_dist*Holiday, data))