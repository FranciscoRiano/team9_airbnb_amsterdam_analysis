DATA = ../../data
INPUT = ../../gen/input
OUTPUT = ../../gen/output

all: $(DATA)/holidays_nl_north.csv $(DATA)/calendar.csv $(DATA)/listings.csv $(DATA)/tram_metro_stops.csv $(DATA)/swimmingpools.csv $(DATA)/religion.csv $(DATA)/park.csv $(DATA)/sport.csv $(INPUT)/distances_infra.csv $(INPUT)/calendar_holiday_distance.csv.gz $(OUTPUT)/calendar_holiday_distance_clean.csv.gz

$(DATA)/holidays_nl_north.csv calendar.csv listings.csv tram_metro_stops.csv swimmingpools.csv religion.csv park.csv sport.csv: dprep_download.R
	R --vanilla < dprep_download.R

$(INPUT)/distances_infra.csv: dprep_distance.R $(DATA)/listings.csv $(DATA)/tram_metro_stops.csv $(DATA)/swimmingpools.csv $(DATA)/religion.csv $(DATA)/park.csv $(DATA)/sport.csv
	R --vanilla < dprep_distance.R

$(INPUT)/calendar_holiday_distance.csv.gz: dprep_merging.R $(DATA)/tram_metro_stops.csv $(DATA)/listings.csv $(DATA)/calendar.csv $(DATA)/holidays_nl_north.csv
	R --vanilla < dprep_merging.R

$(OUTPUT)/calendar_holiday_distance_clean.csv.gz: dprep_clean.R $(INPUT)/calendar_holiday_distance.csv.gz
	R --vanilla < dprep_clean.R
