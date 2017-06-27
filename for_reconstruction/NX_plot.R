library('RColorBrewer')

source('/Volumes/dump/scripts/getNX.R')

setwd('/Volumes/dump/projects/mites/jens_assemblies')

ass_stats <- read.csv('./NX_stats.tsv', header = F, sep = '\t')
colnames(ass_stats) <- c('kmer','X','NX','Norder')

# filter our same assemblies (my retardation!!!)
ass_stats <- ass_stats[!ass_stats$kmer > 67,]
n <- length(unique(ass_stats$kmer))
pal <- brewer.pal(n, 'RdYlGn')

png('/Volumes/dump/pictures/pool/ngs/assembly/mites_NX_graph.png')

index = 1
plot(c(), xlim = c(0,100), ylim = c(0,max(ass_stats$NX)),  xlab = 'X', ylab = 'NX', main = 'mite')
for(kmer in unique(ass_stats$kmer)){
  kmer_stats <- ass_stats[ass_stats$kmer == kmer,]
  lines(kmer_stats$NX ~ seq(10,90,by = 10), col = pal[index])
  points(kmer_stats$NX ~ seq(10,90,by = 10), pch = 20 , col = pal[index])
  index = index + 1
}

legend('topright', col = pal, pch = 20, legend = unique(ass_stats$kmer))

dev.off()

png('/Volumes/dump/pictures/pool/ngs/assembly/mites_N50_graph.png')
N50stats <- ass_stats[ass_stats$X == 'N50',]

index = 1
plot(N50stats$kmer, N50stats$NX, xlim = c(49,99), ylim = c(min(N50stats$NX),max(N50stats$NX)),  xlab = 'kmer', ylab = 'N50', main = 'mite', pch = 20)
lines(N50stats$kmer, N50stats$NX)
text(80, 3500, labels = '?', cex = 10)

dev.off()

setwd('/Volumes/dump/projects/timema/assembly/')

png('/Volumes/dump/pictures/pool/ngs/assembly/Tge_NX_graph.png')

files <- paste0('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/',
                dir('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/'))


X <- seq(0,100, by = 1)
n <- length(files)
pal <- brewer.pal(n, 'RdYlGn')

plot(c(), ylim = c(0,25000), xlim = c(0,100), xlab = 'X', ylab = 'NX', main = 'Tge')
for(i in 1:n){
  cl <- read.csv(files[i], header = F)$V1
  NX <- getNX(cl, X)
  lines(NX ~ X, type = 'l', col = pal[i])
}

legend('topright', col = pal, pch = 20, legend = substr(files,
                                                        nchar('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/')+5,
                                                        nchar('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/')+7))

dev.off()

png('/Volumes/dump/pictures/pool/ngs/assembly/Tge_cumsum_graph.png')

files <- paste0('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/',
                dir('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/'))

n <- length(files)
pal <- brewer.pal(n, 'RdYlGn')

plot(c(), ylim = c(0,1.3e9), xlim = c(0,100), xlab = 'X', ylab = 'NX', main = 'Tge')
for(i in 1:n){
  cl <- read.csv(files[i], header = F)$V1
  cl <- cumsum(sort(cl, decreasing = T, na.last = T))
  X <- seq(0,100, length.out = length(cl))
  lines(cl ~ X, type = 'l', col = pal[i])
}

legend('topleft', col = pal, pch = 20, 
       legend = substr(files, 
                       nchar('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/')+5, 
                       nchar('/Volumes/dump/data/sequences/draft_genomes/timema/Tge/')+7))

dev.off()

files <- '/Volumes/dump/data/sequences/draft_genomes/timema/Tce/lengths_43_Tce.csv'
png('/Volumes/dump/pictures/pool/ngs/assembly/Tce_NX_graph.png')

X <- seq(0,100, by = 1)
cl <- read.csv(files, header = F)$V1
NX <- getNX(cl, X)
plot(NX ~ X, xlim = c(0,100), xlab = 'X', ylab = 'NX', main = 'Tce', type = 'l', col = pal[1])

getNX(cl,50)
sum(cl)

dev.off()

png('/Volumes/dump/pictures/pool/ngs/assembly/Tce_cumsum_graph.png')

plot(c(), ylim = c(0,1.3e9), xlim = c(0,log10(length(cl))), xlab = 'log_10 # contig', ylab = 'cumulative length', main = 'Tce')
cl <- read.csv(files, header = F)$V1
cl <- cumsum(sort(cl, decreasing = T, na.last = T))
X <- 1:length(cl)
lines(cl ~ log(X,10), type = 'l', col = pal[1])

dev.off()

files <- '/Volumes/dump/data/sequences/draft_genomes/timema/Tdi/Tdi_K43_lengths.csv'

png('/Volumes/dump/pictures/pool/ngs/assembly/Tdi_NX_graph.png')
X <- seq(0,100, by = 1)
cl <- read.csv(files, header = F)$V1
NX <- getNX(cl, X)
plot(NX ~ X, xlim = c(0,100), xlab = 'X', ylab = 'NX', main = 'Tdi', type = 'l', col = pal[1])

getNX(cl,50)
sum(cl)

dev.off()

png('/Volumes/dump/pictures/pool/ngs/assembly/Tdi_cumsum_graph.png')

plot(c(), ylim = c(0,1.3e9), xlim = c(0,log10(length(cl))), xlab = 'log_10 # contig', ylab = 'cumulative length', main = 'Tdi')
cl <- read.csv(files, header = F)$V1
cl <- cumsum(sort(cl, decreasing = T, na.last = T))
X <- 1:length(cl)
lines(cl ~ log(X,10), type = 'l', col = pal[1])

dev.off()

png('/Volumes/dump/pictures/pool/ngs/assembly/Tdi_Tce_cumsum_graph.png')

files <- '/Volumes/dump/data/sequences/draft_genomes/timema/Tdi/Tdi_K43_lengths.csv'
Tdi_cl <- read.csv(files, header = F)$V1
Tdi_cl <- cumsum(sort(Tdi_cl, decreasing = T, na.last = T))
files <- '/Volumes/dump/data/sequences/draft_genomes/timema/Tce/lengths_43_Tce.csv'
Tce_cl <- read.csv(files, header = F)$V1
Tce_cl <- cumsum(sort(Tce_cl, decreasing = T, na.last = T))

plot(c(), ylim = c(0,1.3e9), xlim = c(0,log10(max(length(Tdi_cl),length(Tce_cl)))), xlab = 'log_10 # contig', ylab = 'cumulative length', main = 'Tdi')
X <- 1:length(Tdi_cl)
lines(Tdi_cl ~ log(X,10), type = 'l', col = pal[1])
X <- 1:length(Tce_cl)
lines(Tce_cl ~ log(X,10), type = 'l', col = pal[3])

legend('topleft', col = pal[c(1,3)], pch = 20, legend = c('Tdi','Tce'))

dev.off()
