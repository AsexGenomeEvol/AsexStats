source(paste0(Sys.getenv("TROOT"), '/scripts/R/get_optimal_asm.R'))
source(paste0(Sys.getenv("TROOT"), '/scripts/R/batch_subset.R'))

sp = commandArgs(trailingOnly=TRUE)[1]

scf_file <- paste0('stats/assemblies/',sp,'_scfs.tsv')
ctg_file <- paste0('stats/assemblies/',sp,'_ctgs.tsv')

ctg_asm <- read.table(ctg_file, header = T)
scf_asm <- read.table(scf_file, header = T)
scf_asm_b1 <- batch_subset(scf_asm, 1)
scf_asm_b2 <- batch_subset(scf_asm, 2)
scf_asm_b3 <- batch_subset(scf_asm, 3)

all_dir <- unique(c(as.character(scf_asm$dir), as.character(ctg_asm$dir)))

opt <- c(as.character(ctg_asm$dir[get_opt_asm(ctg_asm)]),
         as.character(scf_asm$dir[get_opt_asm(scf_asm)]),
         as.character(scf_asm_b1$dir[get_opt_asm(scf_asm_b1)]),
         as.character(scf_asm_b2$dir[get_opt_asm(scf_asm_b2)]),
         as.character(scf_asm_b3$dir[get_opt_asm(scf_asm_b3)]))

suboptimal <- all_dir[!(all_dir %in% opt)]
present <- dir(paste0('data/',sp,'/assembly/'))
suboptimal_present <- suboptimal[suboptimal %in% present]

batches <- c('ctgs', 'scfs', paste0('batch', 1:3))
all_asm <- list(ctg_asm, scf_asm, scf_asm_b1, scf_asm_b2, scf_asm_b3)

if(sp == '1_Tdi'){
  write(paste('sp', 'asm', 'batch', 'N50', 'NG50', 'total_sum', 'score', sep = '\t'), stderr())
}
for(i in 1:5){
  asm <- all_asm[[i]]
  optimal_asm <- asm$dir == opt[i]
  write(paste(sp, opt[i], batches[i], asm[optimal_asm,'N50'], asm[optimal_asm,'NG50'],
              asm[optimal_asm,'total_sum'], round(asm[optimal_asm,'score'], 4), sep = '\t'),
        stderr())
}

cat(paste(suboptimal_present, collapse = " "))
