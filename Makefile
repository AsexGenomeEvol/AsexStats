VARIABLES := timemas species_pairs sex_red asex_blue
DATA_FILES := $(patsubst %, data/%.rdata, $(VARIABLES))
# replace path by Rscript -e "noquote(.libPaths())" | tail -1 | cut -f 2 -d ' '
INSTALLATION := /Library/Frameworks/R.framework/Versions/3.3/Resources/library/AsexStats

.PHONY : install
install : $(INSTALLATION)
	
$(INSTALLATION) : $(DATA_FILES) R/*
	Rscript install.R

data/%.rdata : data-raw/%.R
	Rscript $<
