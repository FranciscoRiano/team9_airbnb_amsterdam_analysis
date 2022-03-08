DATA = ../../data
INPUT = ../../gen/input
OUTPUT = ../../gen/output

all: $(DATA)/holidays_nl_north.csv $(DATA)/distance.csv $(DATA)/calendar.csv $(DATA)/listings.csv $(DATA)/tram_metro_stops.csv $(INPUT)/calendar_holiday_distance.csv.gz $(OUTPUT)/calendar_holiday_distance_clean.csv.gz

$(DATA)/holidays_nl_north.csv: dprep_download.R
	mkdir -p ../../data
	R --vanilla < dprep_download.R

$(DATA)/distance.csv: dprep_download.R
	R --vanilla < dprep_download.R

$(DATA)/calendar.csv: dprep_download.R
	R --vanilla < dprep_download.R

$(DATA)/listings.csv: dprep_download.R
	R --vanilla < dprep_download.R

$(DATA)/tram_metro_stops.csv: dprep_download.R
	R --vanilla < dprep_download.R

$(INPUT)/calendar_holiday_distance.csv.gz: dprep_merging.R $(DATA)/tram_metro_stops.csv $(DATA)/listings.csv $(DATA)/calendar.csv $(DATA)/distance.csv $(DATA)/holidays_nl_north.csv
	mkdir -p ../../gen/input
	R --vanilla < dprep_merging.R

$(OUTPUT)/calendar_holiday_distance_clean.csv.gz: dprep_merging.R $(INPUT)/calendar_holiday_distance.csv.gz
	mkdir -p ../../gen/output
	R --vanilla < dprep_clean.R





