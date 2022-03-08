# Get final dataset
data <- fread("../../data/calendar_holiday_distance.csv.gz")

#Cleaning data
data$price <- as.numeric(gsub("\\$", "", data$price))
data$adjusted_price <- as.numeric(gsub("\\$", "", data$adjusted_price))
sum(is.na(data))

file.remove("../../data/calendar_holiday_distance.csv.gz")
fwrite(data, "../../gen/output/calendar_holiday_distance_clean.csv.gz")

