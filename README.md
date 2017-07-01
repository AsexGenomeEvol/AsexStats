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
- use command `make` for rebuilding package - it automatically detects updates of integrated datasets/variables.
- use branches for development of the new features
