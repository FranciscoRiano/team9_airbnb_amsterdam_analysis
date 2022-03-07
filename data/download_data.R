# Libraries
library(googledrive)
library(data.table)
library(tidyverse)

# Raw Data Download
downloads <- list(c(id = "1MLHy1bBmdO16cE51vAAIctJgAxFqAR4L", name = 'holidays_nl_north'),
                  c(id = "1YRK4IeLlgQfoqRuhXnDsPUw9ah7Kx6pw", name = "distance"),
                  c(id = "1eVjkmqxJ1q_bHOJ3DPnY0vAvq4nPSEFQ", name = "calendar"),
                  c(id = "1KRSJk45onLk5SHg13w8pS55sIvCvNXPy", name = "listings"),
                  c(id = "1y3IDsiUVEOBynZohi-nD0JUjm9ah16nq", name = "tram_metro_stops"))

for (file in downloads) {
  drive_download(as_id(file['id']), 
                 path = paste0('data/', file['name'], '.csv'), overwrite = TRUE)
}

# Data Import
holidays <- fread("data/holidays_nl_north.csv")
calendar <- fread("data/calendar.csv")
listings <- fread("data/listings.csv")
distance <- fread("data/distance.csv")
tram_metro_stops <- fread("data/tram_metro_stops.csv")

# Change strings to date, so we can join on them
holidays$Date <- as.Date(holidays$Date, "%d-%m-%Y")
calendar$date <- as.Date(calendar$date, "%Y-%m-%d")

# Dataset merging
listings <- listings %>% select(c(id, property_type, room_type, accommodates, bedrooms, beds))
listings <- listings %>% left_join(distance, by = "id")

calendar <- calendar %>% left_join(listings, by = c("listing_id" = "id"))
calendar <- calendar %>% left_join(holidays, by= c("date" = "Date"))

# Write csv.gz file with all the datasets together
fwrite(calendar, "data/calendar_holiday_distance.csv.gz")

# Get final dataset
data <- fread("data/calendar_holiday_distance.csv.gz")

# Remove unnecessary files
file.remove("data/calendar.csv")
file.remove("data/listings.csv")
file.remove("data/holidays_nl_north.csv")
file.remove("data/distance.csv")
file.remove("data/calendar_holiday_distance.csv.gz")
file.remove("data/tram_metro_stops.csv")
