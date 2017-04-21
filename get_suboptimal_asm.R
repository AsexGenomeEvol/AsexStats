source(paste0(Sys.getenv("TROOT"), '/scripts/R/get_optimal_asm.R'))

sp = commandArgs(trailingOnly=TRUE)[1]

scf_file <- paste0('stats/assemblies/',sp,'_scfs.tsv')
ctg_file <- paste0('stats/assemblies/',sp,'_ctgs.tsv')

scf_asm <- read.table(scf_file, header = T)
ctg_asm <- read.table(ctg_file, header = T)

all_dir <- unique(c(as.character(scf_asm$dir), as.character(ctg_asm$dir)))

opt <- c(as.character(scf_asm$dir[get_opt_asm(scf_asm)]),
         as.character(ctg_asm$dir[get_opt_asm(ctg_asm)]))

suboptimal <- all_dir[!(all_dir %in% opt)]
present <- dir(paste0('data/',sp,'/assembly/'))

suboptimal_present <- suboptimal[suboptimal %in% present]

write(sp, stderr())
write(paste("Keeping:", opt[1], scf_asm[scf_asm$dir == opt[1],'NG50']), stderr())
write(paste("Keeping:", opt[2], ctg_asm[ctg_asm$dir == opt[2],'NG50']), stderr())
cat(paste(suboptimal_present, collapse = " "))
