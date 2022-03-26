library(data.table)
library(tidyverse)

# Data Import
holidays <- fread("../../data/holidays_nl_north.csv", select=c("Date", "Holiday", "Day"))
calendar <- fread("../../data/calendar.csv", select = c("listing_id", "date", "price", "adjusted_price"))
listings <- fread("../../data/listings.csv", select = c("id", "neighbourhood_cleansed"))
distance <- fread("../../gen/input/distances_infra.csv")

#Add Weekend Variable
holidays <- holidays %>% mutate(Weekend = (Day == '7'| Day =='1'))

# Change strings to date, so we can join on them
holidays$Date <- as.Date(holidays$Date, "%d-%m-%Y")
calendar$date <- as.Date(calendar$date, "%Y-%m-%d")

# Dataset merging
listings <- listings %>%
  left_join(distance, by = "id")

calendar <- calendar %>% left_join(listings, by = c("listing_id" = "id"))%>%
  left_join(holidays, by= c("date" = "Date"))

#Make directory
dir.create("../../gen")
dir.create("../../gen/input")

# Write csv.gz file with all the datasets together
fwrite(calendar, "../../gen/input/calendar_holiday_distance.csv.gz")
