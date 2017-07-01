VARIABLES := timemas species_pairs sex_red asex_blue
DATA_FILES := $(patsubst %, data/%.rdata, $(VARIABLES))

.PHONY : install
install : $(DATA_FILES)
	Rscript install.R

data/%.rdata : data-raw/%.R
	Rscript $<
