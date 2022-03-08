#Get clean and merged dataset
data <- fread("../../gen/output/calendar_holiday_distance_clean.csv.gz")

#Correlation matrix
library(Hmisc)
data %>%
  select(price, adjusted_price, distance_to_the_centraal_station, Holiday) %>%
  as.matrix() %>%
  rcorr(type="spearman")

#Regression
summary(lm(price ~ distance_to_the_centraal_station*Holiday, data))