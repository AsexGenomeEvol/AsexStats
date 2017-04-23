sp <- commandArgs(trailingOnly=TRUE)[1]

source(paste0(Sys.getenv('TROOT'), '/scripts/R/variables.R'))

# should probvably read kmergenie output, nevermind
opt_k <- c(87,83,87,83,89,83,81,81,87,65)[sp == timemas]

cat(opt_k)#,"\n")
