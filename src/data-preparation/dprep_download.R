# Libraries
library(googledrive)

# Raw Data Download
downloads <- list(c(id = "1MLHy1bBmdO16cE51vAAIctJgAxFqAR4L", name = 'holidays_nl_north'),
                  c(id = "1YRK4IeLlgQfoqRuhXnDsPUw9ah7Kx6pw", name = "distance"),
                  c(id = "1eVjkmqxJ1q_bHOJ3DPnY0vAvq4nPSEFQ", name = "calendar"),
                  c(id = "1KRSJk45onLk5SHg13w8pS55sIvCvNXPy", name = "listings"),
                  c(id = "1y3IDsiUVEOBynZohi-nD0JUjm9ah16nq", name = "tram_metro_stops"))

for (file in downloads) {
  drive_download(as_id(file['id']), 
                 path = paste0('../../data/', file['name'], '.csv'), overwrite = TRUE)
}
