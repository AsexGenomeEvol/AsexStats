library(Rsamtools)

SOAPcov <- read.csv('../data/mapping/3_Tms_genome.cov', header = F, sep = '\t')

pdf('3_Tms_SOAP_scaffold_coverage.pdf')
  hist(SOAPcov$V2, breaks = 100, cex.lab = 1.5, main = 'Average scaffold coverages', xlab = 'Coverage')
dev.off()

pdf('3_Tms_scf1_coverage_vs_expectation.pdf')

  scaf_cov <- read.csv('../data/mapping/scaf1.cov', header = F)$V1

  newlength <- ceiling(length(scaf_cov)/1000)*1000
  scaf_cov[newlength] <- NA
  cov_matrix <- matrix(scaf_cov,nrow=1000)
  cov_1000bp <- colMeans(cov_matrix, na.rm=TRUE)
  
  plot(cov_1000bp, type = 'l', xlab = 'position on scaffold 1 (kb)', ylab = 'average coverage')

  reads_to_generate <- round(sum(scaf_cov, na.rm = T) / 100)
  
  rdu<-function(n,k) sample(1:k,n,replace=T)
  
  pos_from <- rdu(reads_to_generate, length(scaf_cov) - 100)
  generated_cov <- rep(0, length(scaf_cov))
  
  for(i in pos_from){
    generated_cov[i:(i+100)] = generated_cov[i:i+100] + 1;
  }
  
  cov_matrix <- matrix(generated_cov,nrow=1000)
  cov_1000bp <- colMeans(cov_matrix, na.rm=TRUE)
  
  lines(cov_1000bp,col = 'green')

dev.off()
