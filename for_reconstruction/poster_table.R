### TABLE

files <- dir("../data/timema_asm/lengths", full.names = T)

source('/Volumes/dump/scripts/R/genomics/getN50.R')

res <- data.frame(sp = character(0), total = numeric(0), N50 = numeric(0), contigs = numeric(0))

contig_sizes <- as.data.frame(matrix(0,nrow = 10, ncol = 10))

for(file in files){
  contigs <- read.csv(file, header = F)$V1
  contig_sizes[which(file == files),] <- contigs[order(contigs, decreasing = T)][1:10]

  res <- rbind(res,
               data.frame(sp = substr(file, 50, 54),
                          total = round(sum(contigs) / 1000000000, 3),
                          N50 =   getN50(contigs),
                          contigs = length(contigs)))

}

cegma <- read.csv('../data/blasting/cegma_genome_trans.csv', sep = '\t', skip = 1)

cegma_tab <- data.frame(sp = cegma$Species[1:8], genome = cegma$complete.....1[1:8], tanscriptome = cegma$complete.....1[13:20])
cegma_tab <- cegma_tab[c(4,6,7,3,5,2,8,1),]
cegma_tab$sp <- as.character(cegma_tab$sp)
cegma_tab$genome <- as.numeric(levels(cegma_tab$genome)[cegma_tab$genome])
cegma_tab$tanscriptome <- as.numeric(levels(cegma_tab$tanscriptome)[cegma_tab$tanscriptome])

cegma_tab <- rbind(cegma_tab, data.frame(sp = c('Tge','Tpa'), genome = c(47.18,19.35), tanscriptome = c(91.13,78.63)))

res$sp <- factor(substr(res$sp,3,5))

genes_in_genome <- read.csv('/Volumes/dump/projects/timema/assembly/evaluation/trancriptome_in_genome.csv', row.names = 1)

genes_in_genome <- genes_in_genome[,c(1,4)]
genes_in_genome$compl <- round(genes_in_genome$compl / 3088, 3) * 100

GIs_files <- dir('/Volumes/dump/projects/timema/timema_asm/GIs/', full.names = T)

GIs_sum <- data.frame(sp = character(0), total = numeric(0), N50 = numeric(0), contigs = numeric(0))

GIs <- read.csv(GIs_files[1])

for(GIs_file in GIs_files[-1]){

  GIs <- rbind(GIs, read.csv(GIs_file))

}

GIs$sex <- 0
GIs$sex[c(1:10, 31:40, 51:60,71:90)] <- 1

pdf('/Volumes/dump/pictures/pool/stick/GIs/proportion_histogram.pdf')
par(mar = c(5,5,1,0) + 0.2)
hist(GIs$prop[GIs$sex == 1],
     ylim = c(0,15),
     xlim = c(min(GIs$prop),
              max(GIs$prop)),
     col = cols[2], main = '',
     xlab = 'Proportion of HGT candidates',
     bty="n",
     cex.axis = 1.5,
     cex.lab = 1.5)
hist(GIs$prop[GIs$sex == 0], breaks = 20, add = T, col = cols[1])
legend('topright', c('asexual', 'sexual', 'species'),
       pch = c(20,20,NA), cex = 2, col = c(rev(cols), NA),
       title = 'Scaffolds of')
dev.off()

t.test(GIs$prop[GIs$sex == 1], GIs$prop[GIs$sex == 0])

contig_sizes <- as.matrix(contig_sizes) / 1000000
GIs_number <- matrix(GIs$number, byrow = T, ncol = 10)
GIs_prop <- matrix(GIs$prop, byrow = T, ncol = 10)



merge(merge(res[,c(1:3)], cegma_tab[,c(1,2)]), genes_in_genome)

poster_table <- merge(merge(merge(res[,c(1:3)], cegma_tab[,c(1,2)]), genes_in_genome), data.frame(sp = res$sp, deviant_regions = rowSums(GIs_number), proportion = round(rowMeans(GIs_prop * 100),2)))

source('/Volumes/dump/scripts/R/start_up/table_print.R')
print.latextable(poster_table[c(8,4,3,9,2,6,7,5,1,10),])


### HISTOGRAMS

files <- dir("/Volumes/dump/projects/timema/timema_asm/lengths", full.names = T)
asexes = c(1,0,0,1,0,1,0,1,1,0)

library(RColorBrewer)
cols <- brewer.pal(8,"RdBu")[c(6,2)]
cols[1] <- paste0(cols[1], 'CD')
cols[2] <- paste0(cols[2], 'ED')


# c(bottom, left, top, right) The default is c(5, 4, 4, 2) + 0.1.

for(pair in 2:5){
  index = (pair*2) - 1
  if(asexes[index] == 1){
    sindex <- index + 1
    aindex <- index
  } else {
    sindex <- index
    aindex <- index + 1
  }

  contigs <- read.csv(files[sindex], header = F)$V1
  contigs2 <- read.csv(files[aindex], header = F)$V1\
  sp1 = substr(files[sindex], 52, 54)
  sp2 = substr(files[aindex], 52, 54)

  pdf(paste0('/Volumes/dump/pictures/pool/stick/', pair, '_', sp1, '_', sp2, '_logcontigs.pdf'))

  plot_log_hist(sex_data = contigs, asex_data = contigs2)




#  text(1200000,5.8,'Scaffold distribution', cex = 3)

  dev.off()
}
