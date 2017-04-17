sp = commandArgs(trailingOnly=TRUE)[1]

scf_file <- paste0('stats/assemblies/',sp,'_scfs.tsv')
ctg_file <- paste0('stats/assemblies/',sp,'_ctgs.tsv')

scf_asm <- read.table(scf_file)
ctg_asm <- read.table(ctg_file)

all_dir <- unique(c(as.character(scf_asm$dir), as.character(ctg_asm$dir)))

opt <- c(as.character(scf_asm$dir[which.max(scf_asm$NG50)]),
         as.character(ctg_asm$dir[which.max(ctg_asm$NG50)]))

suboptimal <- all_dir[!(all_dir %in% opt)]
present <- dir(paste0('data/',sp,'/assembly/'))

suboptimal_present <- suboptimal[suboptimal %in% present]

write(paste("Keeping:",paste(opt, collapse = " ")), stderr())
cat(paste(suboptimal_present, collapse = " "))
