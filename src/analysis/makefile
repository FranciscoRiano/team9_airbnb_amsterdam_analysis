OUTPUT = ../../gen/output

$(OUTPUT)/scatter_price_distance.pdf: dprep_analysis.R $(OUTPUT)/calendar_holiday_distance_clean.csv.gz
	R --vanilla < dprep_analysis.R