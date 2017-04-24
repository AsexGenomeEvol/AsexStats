source(paste0(Sys.getenv("TROOT"), '/scripts/R/get_optimal_asm.R'))
source(paste0(Sys.getenv("TROOT"), '/scripts/R/batch_subset.R'))

sp = commandArgs(trailingOnly=TRUE)[1]

scf_file <- paste0('stats/assemblies/',sp,'_scfs.tsv')
ctg_file <- paste0('stats/assemblies/',sp,'_ctgs.tsv')

scf_asm <- read.table(scf_file, header = T)
scf_asm_b1 <- batch_subset(scf_asm, 1)
scf_asm_b2 <- batch_subset(scf_asm, 2)
scf_asm_b3 <- batch_subset(scf_asm, 3)
ctg_asm <- read.table(ctg_file, header = T)

all_dir <- unique(c(as.character(scf_asm$dir), as.character(ctg_asm$dir)))

opt <- c(as.character(scf_asm$dir[get_opt_asm(scf_asm)]),
         as.character(ctg_asm$dir[get_opt_asm(ctg_asm)]),
         as.character(scf_asm_b1$dir[get_opt_asm(scf_asm_b1)]),
         as.character(scf_asm_b2$dir[get_opt_asm(scf_asm_b2)]),
         as.character(scf_asm_b3$dir[get_opt_asm(scf_asm_b3)]))

suboptimal <- all_dir[!(all_dir %in% opt)]
present <- dir(paste0('data/',sp,'/assembly/'))

suboptimal_present <- suboptimal[suboptimal %in% present]

write(sp, stderr())
write(paste("Keeping (ctg):", opt[1], scf_asm[scf_asm$dir == opt[1],'NG50']), stderr())
write(paste("Keeping (scf):", opt[2], ctg_asm[ctg_asm$dir == opt[2],'NG50']), stderr())
write(paste("Keeping (batch1):", opt[3], scf_asm_b1[scf_asm_b1$dir == opt[3],'NG50']), stderr())
write(paste("Keeping (batch2):", opt[4], scf_asm_b2[scf_asm_b2$dir == opt[4],'NG50']), stderr())
write(paste("Keeping (batch3):", opt[5], scf_asm_b3[scf_asm_b3$dir == opt[5],'NG50']), stderr())
cat(paste(suboptimal_present, collapse = " "))
