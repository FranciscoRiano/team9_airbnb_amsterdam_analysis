library(data.table)

#Get clean and merged dataset
data <- fread("../../gen/output/calendar_holiday_distance_clean.csv.gz")

#model with distance and number of acc in 500 meter radius, with interaction of Public Transport with weekend and holiday
model_dist_num_wkend_hol <- lm(price ~ tram_dist + tram_number_in_500 +
                           metro_dist + metro_number_in_500 +
                           cs_dist + cs_number_in_500 +
                           swim_dist + swim_number_in_500 +
                           religion_dist + religion_number_in_500 +
                           park_dist + park_number_in_500 +
                           schiphol_dist +
                           sport_dist + sport_number_in_500 +
                           Weekend*metro_dist + Weekend*tram_dist + Weekend*cs_dist + Weekend*schiphol_dist +
                           Holiday*metro_dist + Holiday*tram_dist + Holiday*cs_dist + Holiday*schiphol_dist +
                           neighbourhood_cleansed
                         , data, na.action = na.omit)
summary(model_dist_num_wkend_hol)

#model with log distance and number of acc in 500 meter radius, with interaction of Public Transport with weekend and holiday
model_log_dist_num_wkend_hol <- lm(price ~ log(tram_dist) + tram_number_in_500 + I(log(tram_dist)^2) +
                           log(metro_dist) + metro_number_in_500 + I(log(metro_dist)^2) +
                           log(cs_dist) + cs_number_in_500 + I(log(cs_dist)^2) +
                           log(swim_dist) + swim_number_in_500 + I(log(swim_dist)^2) +
                           log(religion_dist) + religion_number_in_500 + I(log(religion_dist)^2) +
                           log(park_dist) + park_number_in_500 + I(log(park_dist)^2) +
                           log(schiphol_dist)+ I(log(schiphol_dist)^2) +
                           log(sport_dist) + sport_number_in_500 + I(log(sport_dist)^2) +
                           Weekend*log(metro_dist) + Weekend*log(tram_dist) + Weekend*log(cs_dist) + Weekend*log(schiphol_dist) +
                           Holiday*log(metro_dist) + Holiday*log(tram_dist) + Holiday*log(cs_dist) + Holiday*log(schiphol_dist) +
                           neighbourhood_cleansed
                         , data, na.action = na.omit)
summary(model_log_dist_num_wkend_hol)

#Save output in csv
library(broom)
write.csv(tidy(model_dist_num_wkend_hol) , "../../gen/output/model_dist_num_wkend_hol.csv")
write.csv(tidy(model_log_dist_num_wkend_hol) , "../../gen/output/model_log_dist_num_wkend_hol.csv")

