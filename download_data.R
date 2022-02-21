# Libraries
library(googledrive)

# Create directory
dir.create("data")

# Download raw data
download_data <- function(url, filename, filepath) {
  download.file(url = url, destfile = paste0(filepath, filename))
}

download_data(url = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/reviews.csv.gz",
              filename = "reviews.csv", filepath = "data/")

download_data(url = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/calendar.csv.gz",
              filename = "calendar.csv", filepath = "data/")

download_data(url = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/listings.csv.gz",
              filename = "listings.csv", filepath = "data/")

reviews <- read.csv("data/reviews.csv")
calendar <- read.csv("data/calendar.csv")
listings <- read.csv("data/listings.csv")


# Download File Removal
file.remove("data/reviews.csv")
file.remove("data/calendar.csv")
file.remove("data/listings.csv")


# Combine and save the dataset

