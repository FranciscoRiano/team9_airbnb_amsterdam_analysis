# Get final dataset
library(data.table)
library(dplyr)
data <- fread("../../gen/input/calendar_holiday_distance.csv.gz")

#Check missing values beofre coercing
sum(is.na(data))

#Cleaning data
data$price <- as.numeric(gsub("\\$", "", data$price))
data$adjusted_price <- as.numeric(gsub("\\$", "", data$adjusted_price))

#Rename long variable name
data <- data %>% rename(dist_cs = distance_to_the_centraal_station)


file.remove("../../gen/input/calendar_holiday_distance.csv.gz")
fwrite(data, "../../gen/output/calendar_holiday_distance_clean.csv.gz")

