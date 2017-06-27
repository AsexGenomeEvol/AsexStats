read_lists <- dir('/Volumes/dump/projects/timema/timema_assembly/lists/reads/', full.names=T)

sp_reads <- read.table(read_lists[1])
sp_reads$V3 <- sp_reads$V2 / 1300000000
sp <- unlist(strsplit(as.character(sp_reads[1,1]), '/'))[2]
