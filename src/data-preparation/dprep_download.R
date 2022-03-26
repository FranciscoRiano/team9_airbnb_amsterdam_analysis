# Libraries
library(googledrive)
#Make data directory
dir.create("../../data")

# Raw Data Download
downloads <- list(c(id = "1MLHy1bBmdO16cE51vAAIctJgAxFqAR4L", name = 'holidays_nl_north'),
                  c(id = "1eVjkmqxJ1q_bHOJ3DPnY0vAvq4nPSEFQ", name = "calendar"),
                  c(id = "1KRSJk45onLk5SHg13w8pS55sIvCvNXPy", name = "listings"),
                  c(id = "1y3IDsiUVEOBynZohi-nD0JUjm9ah16nq", name = "tram_metro_stops"),
                  c(id = "1swshy6dREsJf7N4jlsMzFXZrB9255k7K", name = "park"),
                  c(id = "1Km47bM-oQIqBZzl8OmOhrvtdZGxsB6Yz", name = "religion"),
                  c(id = "19P_lk6b_rY_m2HzZxhg-9wz3ToFgBKd7", name = "sport"),
                  c(id = "1gVFhGvGe0sNMQtbKzfKtp7HK_MsW_02Z", name = "swimmingpools"))

for (file in downloads) {
  drive_download(as_id(file['id']), 
                 path = paste0('../../data/', file['name'], '.csv'), overwrite = TRUE)
}
