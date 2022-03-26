library(data.table)
tram_metro_stops <- read.csv("../../data/tram_metro_stops.csv", sep=';')
listings <- fread("../../data/listings.csv", select = c('id', 'longitude', 'latitude'))
swimmingpools <- read.csv("../../data/swimmingpools.csv", sep=';')
religion <- read.csv("../../data/religion.csv", sep=';')
park <- read.csv("../../data/park.csv", sep=';')
sport <- read.csv("../../data/sport.csv", sep=';')

library(dplyr)

#Filter for tram and metro
tram <- tram_metro_stops %>% filter(Modaliteit == 'Tram')
metro <- tram_metro_stops %>% filter(Modaliteit == 'Metro')

#Manually creation of dataframes containing long and lat of Schiphol and Central Station
Schiphol <- data.frame(
  'LNG' = 4.764167,
  'LAT' = 52.308056
)

centralstat <- data.frame(
  'LNG' = 4.899431,
  'LAT' = 52.379189
)

number_infra_eucl3 <- function(data, lon, lat) {
  all_distances <- sapply(1:nrow(data), function(row) {
    dist <- sqrt(((lon-data[row, 'LNG'])*(40075000/360))^(2)+((lat-data[row, 'LAT'])*(40075000/360))^(2))
    return(dist)
  })
  return(all_distances)
}

datasets <- list(metro, tram, swimmingpools, Schiphol, centralstat, religion, park, sport)
variable_names <- c('metro', 'tram', 'swim', 'schiphol', 'cs', 'religion', 'park', 'sport')
i <- 1
radius <- 500

start <- Sys.time()
for (dataset in datasets) { #This takes 15.49809 mins
  name_min_dist <- paste0(variable_names[i], "_dist")
  print(paste0("Currently working on ", name_min_dist))
  listings <- listings %>%
    mutate(!!name_min_dist := "")
  
  name_num_dist <- paste0(variable_names[i], "_number_in_", radius)
  listings <- listings %>%
    mutate(!!name_num_dist := "") 
  
  for (row in 1:nrow(listings)) {
    long <- listings[[row, 2]]
    lat <- listings[[row, 3]]
    distances_per_row <- number_infra_eucl3(dataset, long, lat)
    listings[row, ncol(listings)-1] = min(distances_per_row)
    listings[row, ncol(listings)] = sum(distances_per_row<radius)
    
  }
  i <- i + 1
}
finish <- Sys.time()
print(finish-start)

#Make directory
dir.create("../../gen")
dir.create("../../gen/input")

# Write csv file with all the datasets together
fwrite(listing, "../../gen/input/distances_infra.csv")
