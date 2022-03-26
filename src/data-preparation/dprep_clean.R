# Get final dataset
library(data.table)
library(dplyr)
data <- fread("../../gen/input/calendar_holiday_distance.csv.gz", nrows=100000)

#Change prices to numeric and remove dollar sign
data$price <- as.numeric(gsub("\\$", "", data$price))
data$adjusted_price <- as.numeric(gsub("\\$", "", data$adjusted_price))

#Make factor of the neighbourhoods
data$neighbourhood_cleansed <- as.factor(data$neighbourhood_cleansed)

#Make directory and write file
dir.create("../../gen/output")

fwrite(data, "../../gen/output/calendar_holiday_distance_clean.csv.gz")

