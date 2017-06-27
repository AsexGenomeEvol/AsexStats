
sp <- c('1_Tps','5_Tge','5_Tge')
is <- c(350,350,550)

for(i in 1:3){
  tab_name <- paste0('variant_',sp[i],'_',is[i])
  theta_file <- paste0('../data/',sp[i],'/variant_calling/GATK/',
                       is[i],'/filtered_variants.vcf')
  assign(tab_name, read.table(theta_file, header = F, stringsAsFactors=F))
}

Tps_ref <- read.table('../data/1_Tps/reference/1_Tps_genome_100k_filtered.fa.fai',
                      stringsAsFactors=F)[,c(1,2)]
colnames(Tps_ref) = c('scf','length')
Tge_ref <- read.table('../data/5_Tge/reference/Tge_abyss87_besst_GC_core_100k_filtered.fa.fai',
                      stringsAsFactors=F)[,c(1,2)]
colnames(Tge_ref) = c('scf','length')

variant_table_Tps_350 <- as.data.frame(table(variant_1_Tps_350$V1))
colnames(variant_table_Tps_350) <- c('scf','SNPs')
Tps_350 <- merge(Tps_ref, variant_table_Tps_350)
Tps_350$SNP_density <- Tps_350$SNPs / Tps_350$length

variant_table_Tge_350 <- as.data.frame(table(variant_5_Tge_350$V1))
colnames(variant_table_Tge_350) <- c('scf','SNPs')
Tge_350 <- merge(Tge_ref, variant_table_Tge_350)
Tge_350$SNP_density <- Tge_350$SNPs / Tge_350$length

variant_table_Tge_550 <- as.data.frame(table(variant_5_Tge_550$V1))
colnames(variant_table_Tge_550) <- c('scf','SNPs')
Tge_550 <- merge(Tge_ref, variant_table_Tge_550)
Tge_550$SNP_density <- Tge_550$SNPs / Tge_550$length

asex_blue <- rgb(92 / 256, 198 / 256, 222 / 256, alpha = 0.4)
sex_red_350 <- rgb(214 / 256, 60 / 256, 77 / 256, alpha = 0.4)
sex_red_550 <- rgb(214 / 256, 40 / 256, 97 / 256, alpha = 0.4)

hist(Tps_350$SNP_density, freq = F, col = asex_blue, main = 'SNP density', xlim = c(0,0.12), xlab = 'SNP_density')
hist(Tge_350$SNP_density, freq = F, col = sex_red_350, add = T, breaks = 100)
#hist(Tge_550$SNP_density, freq = F, col = sex_red_550, add = T, breaks = 60)
legend('topright', c('Tps','Tge'), pch = 20, col = c(asex_blue, sex_red_350))

Tps_atlas_is350 <- read.table('../data/1_Tps/variant_calling/atlas/350/map_pe_to_1_Tps_theta_estimates.txt', header = T)
hist(Tps_atlas_is350$theta_MLE)
