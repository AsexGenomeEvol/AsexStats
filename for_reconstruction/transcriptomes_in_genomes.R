filenames <- dir('../data/blasting/blasthits/',pattern = 'txt', full.names = T)

sp_tab <- data.frame(sp = numeric(0), compl_in1 = numeric(0), compl_in2 = numeric(0), compl = numeric(0))

get4th <- function(vect){
  return(vect[4])
}

for(i in 1:length(filenames)){
  blast_tab <- read.csv(file = filenames[i], sep = '\t', header = F, col.names = c('scaffold','transcript','tlen', 'len','tfrom','tto','sfrom','sto'))
  
  prot_names <- as.character(blast_tab$transcript)
  prot_names <- strsplit(prot_names, split = '_')

  prot_list <- unlist(lapply(prot_names, get4th))
  length(unique(prot_list))
  
  ttab <- data.frame(tr = unique(blast_tab$transcript))
  ttab$perc <- 0
  ttab$cont <- 0
  ttab$garea <- 0
  ttab$tarea
  ttab$len <- 0
  
  for(prot in unique(blast_tab$transcript)){
    prot_tab <- subset(blast_tab, blast_tab$transcript == prot)
    ttab$len[ttab$tr == prot] <- max(prot_tab$tlen)
    ttab$perc[ttab$tr == prot] <- (max(prot_tab$tto) - min(prot_tab$tfrom)) / max(prot_tab$tlen)
    ttab$cont[ttab$tr == prot] <- length(unique(prot_tab$scaffold))
    ttab$tarea[ttab$tr == prot] <- sum(abs(prot_tab$sto - prot_tab$sfrom))
    area <- 0
    for(scaf in unique(prot_tab$scaffold)){
      area <- area + max(prot_tab$sto[prot_tab$scaffold == scaf]) - min(prot_tab$sfrom[prot_tab$scaffold == scaf])
    }
    ttab$garea[ttab$tr == prot] <- area
  }
  
  sp_tab <- rbind(sp_tab, data.frame(
    sp = substr(filenames, 29, 31)[i], 
    compl_in1 = sum(ttab$cont == 1 & ttab$perc > 0.95), 
    compl_in2 = sum(ttab$cont < 3 & ttab$perc > 0.95), 
    compl =   sum(ttab$perc > 0.95) ))
}


sp_tab$cmpl_in2_prop <- sp_tab$compl_in2 / 3088

#pdf('/Volumes/dump/pictures/pool/stick/4_Tbi/length_of_alignments_over_transcript_length.pdf')
#  hist(ttab$tarea / ttab$len, xlab = 'length of alignments / transcript length', main = '')
#dev.off()

#plot(ttab$tarea ~ ttab$cont)

#pdf('/Volumes/dump/pictures/pool/stick/4_Tbi/transipts_over_scfs.pdf')
#  hist(ttab$cont, breaks = 10, xlab = 'Contigs', cex.lab = 1.5)
#dev.off()

#248 core genes
cegma <- read.csv('../data/blasting/cegma_genome_trans.csv', sep = '\t', skip = 1)

cegma_tab <- data.frame(sp = cegma$Species[1:8], genome = cegma$complete.....1[1:8], tanscriptome = cegma$complete.....1[13:20])
cegma_tab <- cegma_tab[c(4,6,7,3,5,2,8,1),]
cegma_tabsex <- rep(c(0,1),4)

write.csv(merge(sp_tab, cegma_tab), file = 'trancriptome_in_genome.csv')


###############################
### analysis of scatterness ###
###############################

library(hash)

# aproximate equal
`%~%` <- function(v1, v2){
  return(abs(v1 - v2) < 25)
}

lengthfiles <- dir("../data/timema_asm/lengths", pattern = 'scaff_lenghts', full.names = T)
lengthfiles <- lengthfiles[order(substr(lengthfiles, 30,32))]
sp_list <- list()

for(i in 1:length(filenames)){
  blast_tab <- read.csv(file = filenames[i], sep = '\t', header = F, col.names = c('scaffold','transcript','tlen', 'slen','tfrom','tto','sfrom','sto'))
  transcript_list <- unique(blast_tab$transcript)
  
  lengths <- read.csv(lengthfiles[i], header = F, sep = '\t', stringsAsFactors = F)  
  lengths <- hash(keys = lengths$V1, values=lengths$V2)
  
  sp_tab <- list()
  
  for(prot in transcript_list){
#    print(prot)
    prot_tab <- ChainHits(subset(blast_tab, blast_tab$transcript == prot))
    
    if(nrow(prot_tab) == 0){
      next;
    }
    
    for(j in 1:nrow(prot_tab)){
      prot_tab$slen[j] <- lengths[[as.character(prot_tab$scaffold[j])]]
    }
    sp_tab[[length(sp_tab)+1]] <- prot_tab
  }
  
  sp_list[[substr(filenames, 29, 31)[i]]] <- sp_tab
}
#sp_tab$cmpl_in2_prop <- sp_tab$compl_in2 / 3088
save(sp_list, file = './sp_list')  


ChainHits <- function(prot_tab){
  prot_tab <- prot_tab[order(prot_tab$tfrom),]
  i <- 1
  while(i <= nrow(prot_tab)){
    if(sum(prot_tab$tto[i] %~% prot_tab$tfrom) != 0){
      toChain <- min(which(prot_tab$tto[i] %~% prot_tab$tfrom))
      if(prot_tab$scaffold[i] != prot_tab$scaffold[toChain]){
        i = i + 1;
        next;
      }
      prot_tab$tto[i] <- prot_tab$tto[toChain]
      prot_tab$sto[i] <- prot_tab$sto[toChain]
      prot_tab <- prot_tab[-toChain,]
    } else{
      i = i + 1
    }
  }
  i <- 1
  while(i < nrow(prot_tab)){
    if(any(prot_tab$tfrom[i] %~% prot_tab$tfrom[-i])){
      toPrune <- which(prot_tab$tfrom[i] %~% prot_tab$tfrom)
      toPrune <- toPrune[!(max(abs(prot_tab$tto[toPrune] - prot_tab$tfrom[toPrune])) == abs(prot_tab$tto[toPrune] - prot_tab$tfrom[toPrune]))]
      prot_tab <- prot_tab[-toPrune,]
    }
    i = i + 1
  }
  return(prot_tab)
}

##########################
### Parsing of sp_list ###
##########################

length(sp_list[[1]])

sp_list[[1]]

getFullgenes <- function(gene_lists){
  fullgenes <- 0
  for(i in 1:length(gene_lists)){
    fullgenes <- fullgenes + any((gene_lists[[i]]$tto - gene_lists[[i]]$tfrom) %~% gene_lists[[i]]$tlen)
    # lapply(any((gene_lists[[i]]$tto - gene_lists[[i]]$tfrom) %~% gene_lists[[i]]$tlen))
  }
  # sum(unlist( ... ))
  return(fullgenes);
}

getFullgenes <- function(gene_lists){
  StoStart <- c()
  StoEnd <- c()
  MtoStart <- c()
  MtoEnd <- c()
  EtoStart <- c()
  EtoEnd <- c()
  
  for(i in 1:length(gene_lists)){
    fullgenes <- fullgenes + any((gene_lists[[i]]$tto - gene_lists[[i]]$tfrom) %~% gene_lists[[i]]$tlen)

  }
  return(fullgenes);
}

getFullgenes(sp_list[[1]])
