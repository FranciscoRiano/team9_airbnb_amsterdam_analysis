# Libraries
library(googledrive)
library(data.table)

# Download holidays
drive_download(
  as_id("https://drive.google.com/file/d/1MLHy1bBmdO16cE51vAAIctJgAxFqAR4L/view?usp=sharing"),
  path = "data/holidays_nl_north.csv",
  overwrite = TRUE)

# Download distance to central station
drive_download(
  as_id("https://drive.google.com/file/d/1YRK4IeLlgQfoqRuhXnDsPUw9ah7Kx6pw/view?usp=sharing"),
  path = "data/distance_cs.csv",
  overwrite = TRUE)

# Data Import
library(tidyverse)
holidays <-read_delim("data/holidays_nl_north.csv", 
                  ";", escape_double = FALSE, trim_ws = TRUE)

# Download raw data: IMPORTANT: cvs.gz & fread to save space and time
download_data <- function(url, filename, filepath) {
  download.file(url = url, destfile = paste0(filepath, filename))
}

download_data(url = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/reviews.csv.gz",
              filename = "reviews.csv.gz", filepath = "data/")

download_data(url = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/calendar.csv.gz",
              filename = "calendar.csv.gz", filepath = "data/")

download_data(url = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/listings.csv.gz",
              filename = "listings.csv.gz", filepath = "data/")

reviews <- fread("data/reviews.csv.gz")
calendar <- fread("data/calendar.csv.gz")
listings <- fread("data/listings.csv.gz")
distance <- fread("data/distance_cs.csv")

# Change strings to date, so we can join on them
holidays$Date <- as.Date(holidays$Date, "%d-%m-%Y")
calendar$date <- as.Date(calendar$date, "%Y-%m-%d")

# Dataset merging
listings <- listings %>% select(c(id, property_type, room_type, accommodates, bedrooms, beds))
listings <- listings %>% left_join(distance, by = "id")

calendar <- calendar %>% left_join(listings, by = c("listing_id" = "id"))
calendar <- calendar %>% left_join(holidays, by= c("date" = "Date"))

#Write csv.gz file with all the datasets together
fwrite(calendar, "data/calendar_holiday_distance.csv.gz")

#Remove unneccesary files
file.remove("data/reviews.csv.gz")
file.remove("data/calendar.csv.gz")
file.remove("data/listings.csv.gz")
file.remove("data/holidays_nl_north.csv")
file.remove("data/distance_cs.csv")
