## AsexStats : an R package for computing stats of asexual genome evolution. Developed specifically for AsexGenomeEvol project

The project is hosted at : https://github.com/AsexGenomeEvol

### Content of the package

I will categorize functions by type (project specific will be somehow marked as well)

#### loading functions

- `filter_thetas` - function for filtering thetas

#### plotting functions

- `sex_legend` - plots a sex/asex legend
- `plot_log_hist` - plots y-log histogram of sex/asex data

#### Misc

- `ssplit` - split a string into vector of substring
- `make_data_frame` - create a data.frame with predefined column names

#### data & variables

- `timema_pairs` - useful descriptors of species pairs (labels, divergence_times, ...)
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

#### local installation

Users on clusters classically do not have a root access and therefore they won't be able to install R packages to the common folders of all the users. To access an R package without root access you need to install the package on some alternative place (like your home) and tell R that there will be an alternative place to look for packages.

The very beginning is the same, download this package, then create a place for your local R packages (`/home/$USER/R` in this example).

```
cd ~
git clone https://github.com/AsexGenomeEvol/AsexStats
mkdir -p /home/$USER/R
CMD INSTALL AsexStats -l /home/$USER/R
```

Now the package was installed to your home (`~/R`). To tell R about the alternative path you set an environmental variable by adding the line `export R_LIBS=/home/$USER/R` into your `.bashrc` file (the setting file of your `bash`)

```
echo "export R_LIBS=/home/$USER/R" >> ~/.bashrc
```

## Development

- testing is done using `testthat` and it is integrated to installation (if test wont pass, installation fails)
- documentation is generated using `devtools` and `roxygen2`
- you can use `make` for rebuilding package - however, the Makefile is not fully portable  (yet?), you need to modify path to your R package inside of the makefile.
- use branches and pull requests for development of the new features

## Adding new data

- create an R script (`*.R`) in folder `data-raw` that will generate a `*.rdata` data file in `data` folder
- add the name of data/scripts in `R/data.R` (use one of previous entries as template)
- add the name to VARIABLES in the `Makefile`
- document and reinstall package
- before making a commit, check that data look as expected and check if the documentation of data (`?mydata`) looks as expected
