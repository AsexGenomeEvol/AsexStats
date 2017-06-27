scaf_lengths <- read.csv('../data/mapping/Tms_scav.lengths', header = F, col.names = c('id','length'), sep = '\t')
scaf_abundances <- read.csv('../data/mapping/Tms_550_mean_scaf.cov', header = F, col.names = c('id', 'abundances'), sep = '\t')

scaf_coverage <- merge(scaf_abundances,scaf_lengths, all = T)

summary(scaf_coverage)


scaf_coverage$abundances[is.na(scaf_coverage$abundances)] <- 1
scaf_coverage$coverage <- scaf_coverage$abundances / scaf_coverage$length

m1 <- median(scaf_coverage$coverage[scaf_coverage$coverage != 0])
m2 <- sum(scaf_coverage$abundances) / 1.3E9
m2 <- sum(scaf_coverage$abundances) / sum(scaf_coverage$length)
m4 <- median(scaf_coverage$coverage)
m5 <- mean(scaf_coverage$coverage)

genome_size <- sum(scaf_coverage$length)
scaf_coverage[,5:7] <- 0

# I assume, that probablity of read to be from scaffold is proportional to its length
# I take the amout of reads as sum of coverages / 100 (I could get read number of reads, but pfff), then I can clame that all simulated reads are 100pb long
# therefore bionomial with p (from length) and n (number of reads)
for(i in 1:nrow(scaf_coverage)){
  scaf_coverage[i,5:7] <- rbinom(3, size = round(sum(scaf_coverage$abundances) / 100), prob = scaf_coverage$length[i] / genome_size) 
}

# then coverage is number of reads * length of reads (100) / length of scaffold
sim1 <- (scaf_coverage$V5 * 100 / scaf_coverage$length)
sim2 <- (scaf_coverage$V6 * 100 / scaf_coverage$length)
sim3 <- (scaf_coverage$V7 * 100 / scaf_coverage$length)

trans_red <- rgb(1, 0.8, 0.2, alpha = 0.5)
trans_teal <- rgb(0, 0.25, 1, alpha = 0.8)

pdf('/Volumes/dump/pictures/pool/stick/3_Tms/scaffold_log_coverages_vs_simulation.pdf')
  # note 35000 scaffolds are without any reads mapping to it.
  hist(log(scaf_coverage$coverage, 10), breaks = 40, main = 'hist of Tms scaffold coverages', xlab = 'log (coverage)', cex.lab = 1.4, col = trans_teal, ylim = c(1, 80000))
  hist(log(sim1,10), breaks = 20, add = T, col = trans_red)
  legend('topright', pch = 20, legend = c('real data', 'simulation'), col = c(trans_teal,trans_red))
dev.off()

pdf('/Volumes/dump/pictures/pool/stick/3_Tms/scaffold_coverages_vs_simulation.pdf')
  hist(scaf_coverage$coverage, breaks = 8000, main = 'hist of Tms scaffold coverages', xlab = 'coverage', cex.lab = 1.4, col = trans_teal, xlim = c(0,100))
  hist(sim1, breaks = 20, add = T, col = trans_red)
  legend('topright', pch = 20, legend = c('real data', 'simulation'), col = c(trans_teal,trans_red))
dev.off()

# make a histogram of 
write.csv(scaf_coverage,file = 'scaf_550_coverages_with_sim.csv')
write.csv(scaf_coverage[,c(1,4)],file = '3_Tms_genome_550_lib.cov', row.names=FALSE, quote = F)

scaf_coverage <- read.csv('scaf_550_coverages_with_sim.csv')
sim1 <- (scaf_coverage$V5 * 100 / scaf_coverage$length)
glob_cov <- read.csv('3_Tms_genome.cov', header = F, sep = '\t')
trans_yellow <- rgb(1, 0.8, 0.2, alpha = 0.5)
trans_teal <- rgb(0, 0.25, 1, alpha = 0.8)
trans_red <- rgb(0.8, 0.1, 0.2, alpha = 0.5)

pdf('/Volumes/dump/pictures/pool/stick/3_Tms/scaffold_glob_and_550_coverages_vs_simulation.pdf')
hist(scaf_coverage$coverage, breaks = 8000, main = 'hist of Tms scaffold coverages', xlab = 'coverage', cex.lab = 1.4, col = trans_teal, xlim = c(0,100))
hist(sim1, breaks = 20, add = T, col = trans_yellow)
hist(glob_cov$V2, breaks = 160, add = T, col = trans_red)
legend('topright', pch = 20, legend = c('real data - lib 550','all real data', 'simulation'), col = c(trans_teal,trans_red,trans_yellow))
dev.off()


scaf_coverage <- read.csv(file = 'scaf_550_coverages_with_sim.csv', row.names = 1)
summary(scaf_coverage)

no_cov <- subset(scaf_coverage, scaf_coverage$abundances == 0)
few_cov <- subset(scaf_coverage, scaf_coverage$coverage < 1)

sum(no_cov$length > 2000)


sum(no_cov$V5 == 0)
sum(no_cov$V6 == 0)
sum(no_cov$V7 == 0)
