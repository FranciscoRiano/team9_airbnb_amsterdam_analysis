library(data.table)
library(tidyverse)

# Data Import
holidays <- fread("../../data/holidays_nl_north.csv")
calendar <- fread("../../data/calendar.csv")
listings <- fread("../../data/listings.csv")
distance <- fread("../../data/distance.csv")
tram_metro_stops <- fread("../../data/tram_metro_stops.csv")

# Change strings to date, so we can join on them
holidays$Date <- as.Date(holidays$Date, "%d-%m-%Y")
calendar$date <- as.Date(calendar$date, "%Y-%m-%d")

# Dataset merging
listings <- listings %>% select(c(id, property_type, room_type, accommodates, bedrooms, beds))
listings <- listings %>% left_join(distance, by = "id")

calendar <- calendar %>% left_join(listings, by = c("listing_id" = "id"))
calendar <- calendar %>% left_join(holidays, by= c("date" = "Date"))

# Write csv.gz file with all the datasets together
fwrite(calendar, "../../gen/output/calendar_holiday_distance.csv.gz")

# Remove unnecessary files
file.remove("../../data/calendar.csv")
file.remove("../../data/listings.csv")
file.remove("../../data/holidays_nl_north.csv")
file.remove("../../data/distance.csv")
file.remove("../../data/tram_metro_stops.csv")
