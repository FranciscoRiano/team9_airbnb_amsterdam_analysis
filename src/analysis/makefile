OUTPUT = ../../gen/output

all: $(OUTPUT)/model_dist_num_wkend_hol.csv $(OUTPUT)/model_log_dist_num_wkend_hol.csv $(OUTPUT)/scatter_price_distance.pdf $(OUTPUT)/report.pdf

$(OUTPUT)/model_dist_num_wkend_hol.csv $(OUTPUT)/model_log_dist_num_wkend_hol.csv: dprep_analysis.R $(OUTPUT)/calendar_holiday_distance_clean.csv.gz
	R --vanilla < dprep_analysis.R

$(OUTPUT)/scatter_price_distance.pdf: dprep_graphs.R $(OUTPUT)/calendar_holiday_distance_clean.csv.gz
	R --vanilla < dprep_graphs.R

$(OUTPUT)/report.pdf: report.Rmd
	R -e "rmarkdown::render('report.Rmd', 'pdf_document', 'AMS_analysis.pdf', '../../gen/output')"


	