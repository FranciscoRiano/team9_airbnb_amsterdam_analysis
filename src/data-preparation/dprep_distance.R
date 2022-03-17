library(data.table)
tram_metro_stops <- read.csv("../../data/tram_metro_stops.csv", sep=';')
listings <- fread("../../data/listings.csv", select = c('id', 'longitude', 'latitude'))
swimmingpools <- read.csv("../../data/ZWEMWATER.csv", sep=';')
religion <- read.csv("../../data/RELIGIE.csv", sep=';')
park <- read.csv("../../data/PARKPLANTSOENGROEN.csv", sep=';')
sport <- read.csv("../../data/SPORT_OPENBAAR.csv", sep=';')

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

#Make function to calculate minimum distance from infra based on Euclidean Distance
minimum_distance_eucl <- function(data, lon, lat) {
  all_distances <- c()
  for (row in 1:nrow(data)) {
    dist <- sqrt(((lon-data[row, 'LNG'])*(40075000/360))^(2)+((lat-data[row, 'LAT'])*(40075000/360))^(2))
    all_distances <- append(all_distances, dist)
  }
  return(min(all_distances))
}

#Make function to calculte number of infra based on Euclidean Distance
number_infra_eucl <- function(data, lon, lat, radius) {
  all_distances <- c()
  for (row in 1:nrow(data)) {
    dist <- sqrt(((lon-data[row, 'LNG'])*(40075000/360))^(2)+((lat-data[row, 'LAT'])*(40075000/360))^(2))
    all_distances <- append(all_distances, dist)
  }
  return(sum(all_distances < radius))
}

number_infra_eucl2 <- function(data, lon, lat, radius) {
  all_distances <- sapply(1:nrow(data), function(row) {
    dist <- sqrt(((lon-data[row, 'LNG'])*(40075000/360))^(2)+((lat-data[row, 'LAT'])*(40075000/360))^(2))
    return(dist)
  })
  return(sum(all_distances < radius))
}


number_infra_eucl3 <- function(data, lon, lat) {
  all_distances <- sapply(1:nrow(data), function(row) {
    dist <- sqrt(((lon-data[row, 'LNG'])*(40075000/360))^(2)+((lat-data[row, 'LAT'])*(40075000/360))^(2))
    return(dist)
  })
  return(all_distances)
}

system.time({void<-number_infra_eucl(swimmingpools, listings$longitude, listings$latitude, radius=500)})
system.time({void<-number_infra_eucl2(swimmingpools, listings$longitude, listings$latitude, radius=500)})


                      
#A for loop that loops over every dataset and adds minimum distance plus number of infras
datasets <- list(metro, tram, swimmingpools, Schiphol, centralstat, religion, park, sport)
variable_names <- c('metro', 'tram', 'swim', 'schiphol', 'cs', 'religion', 'park', 'sport')
i <- 1
radius <- 500

start <- Sys.time()
for (dataset in datasets) {
  name <- paste0(variable_names[i], "_dist")
  print(paste0("Currently working on ", name))
  listings <- listings %>% rowwise() %>%
    mutate(!!name := minimum_distance_eucl(dataset, longitude, latitude))
  name <- paste0(variable_names[i], "_number_in_", radius)
  print(paste0("Currently working on ", name))
  listings <- listings %>% rowwise() %>%
    mutate(!!name := number_infra_eucl(dataset, longitude, latitude, radius))
  i <- i +1
}
finish <- Sys.time()
print(finish-start)

fwrite(listings, "../../gen/input/distances_infra.csv")
