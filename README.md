## AsexStats : an R package for computing stats of asexual genome evolution. Developed specifically for AsexGenomeEvol project

The project is hosted at : https://github.com/AsexGenomeEvol

### Content of the package

I will categorize functions by type (project specific will be somehow marked as well)

#### loading functions

- `load_thetas` - function for loading thetas within [variant_analysis](https://github.com/AsexGenomeEvol/variant_analysis)

#### plotting functions

- `sex_legend` - plots a sex/asex legend

#### data & variables

- `species_pairs` - useful descriptors of species pairs (labels, divergence_times, ...)
- `timemas` - timema species labels stored in a list (codes, labels, ...)
- `asex_blue`, `sex_red` - colours used for asexual and sexual species


### Install

- get the package (clone or download the latest code)
- open terminal in the folder of the package and run `Rscript install.R`,

or using `devtools` package, run `R` and type

```{R}
library(devtools)
install_github("AsexGenomeEvol/AsexStats", build_vignettes=FALSE)
```

## Development

- testing is planned, not done yet (using `testthat` I guess)
- documentation is generated using `devtools` and `roxygen2`
- you can use `make` for rebuilding package - however, the Makefile is not fully portable (yet?)
- use branches for development of the new features

## Adding new data

- create an R script (`*.R`) in folder `data-raw` that will generate a `*.rdata` data file in `data` folder
- add the name of data/scripts in `R/data.R` (use one of previous entries as template)
- add the name to VARIABLES in the `Makefile`
- document and reinstall package
- before making a commit, check that data look as expected and check if the documentation of data (`?mydata`) looks as expected
