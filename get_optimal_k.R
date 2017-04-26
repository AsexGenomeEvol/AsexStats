args <- commandArgs(trailingOnly=TRUE)
sp <- args[1]
if(length(args) == 1){
  batch = 'kmergenie'
} else {
  batch = args[2]
}

troot <- Sys.getenv('TROOT')
source(paste0(troot, '/scripts/R/variables.R'))
source(paste0(troot, '/scripts/R/batch_subset.R'))

if(batch == 'kmergenie' | batch == 3){
  # should probvably read kmergenie output, nevermind
  opt_k <- c(87,83,87,83,89,83,81,81,87,65)[sp == timemas]
} else {
  asm <- read.table(paste0(troot, '/stats/assemblies/',sp,'_scfs.tsv'), header = T)
  opt_k <- batch_subset(asm, batch)$kmer[1]
}

cat(opt_k)#,"\n")
