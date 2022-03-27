OUTPUT = ../../gen/output

all: $(OUTPUT)/scatter_price_distance.pdf $(OUTPUT)/distance_price.png $(OUTPUT)/logdistance_price.png $(OUTPUT)/regression.png $(OUTPUT)/report.html

$(OUTPUT)/scatter_price_distance.pdf $(OUTPUT)/distance_price.png $(OUTPUT)/logdistance_price.png: dprep_graphs.R $(OUTPUT)/calendar_holiday_distance_clean.csv.gz
	R --vanilla < dprep_graphs.R

$(OUTPUT)/regression.png: dprep_analysis.R $(OUTPUT)/calendar_holiday_distance_clean.csv.gz
	R --vanilla < dprep_analysis.R

$(OUTPUT)/report.html: report.Rmd
	R -e "rmarkdown::render('report.Rmd', 'html_document', 'AMS_analysis.html', '../../gen/output')"


	