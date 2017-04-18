args <- commandArgs(trailingOnly=TRUE)

sp = args[1]
batch = as.numeric(args[2])

batch_flags <- c('--nomse --nompe --fewdata', '--nomse --nompe')[batch]
asm_script <- c('$TROOT/C_contig_assembly/2_SOAP.sh', '$TROOT/C_contig_assembly/2_SOAP.sh')[batch]

scf_file <- paste0(troot,'/stats/assemblies/',sp,'_scfs.tsv')
scf_asm <- read.table(scf_file, header = T)

if(batch == 1){
    scf_asm_batch <- scf_asm[scf_asm$fasteris == F &
                             scf_asm$fewdata == T &
                             scf_asm$mse == F &
                             scf_asm$pse == T &
                             scf_asm$mpe == F, ]
} else if(batch == 2){
    scf_asm_batch <- scf_asm[scf_asm$fasteris == F &
                             scf_asm$fewdata == F &
                             scf_asm$mse == F &
                             scf_asm$pse == T &
                             scf_asm$mpe == F, ]
}

setwd(paste0('data/', sp, '/assembly/logs'))

if(nrow(scf_asm_batch[, ]) == 0){
  if(batch < 3){
    soap_asm <- scf_asm[scf_asm$soft == 'SOAP',]
    kmer <- soap_asm[which.max(soap_asm[,'NG50']),'kmer']
  } else {
    abyss_asm <- scf_asm[scf_asm$soft == 'abyss',]
    kmer <- abyss_asm[which.max(abyss_asm[,'NG50']),'kmer']
  }

  write(paste('Submiting assembly from batch', batch, ' with kmer', kmer, '; flags:', batch_flags), stderr())
  system(paste(asm_script, sp, kmer, batch_flags))
}

opt_asm <- which.max(scf_asm_batch$NG50)
opt_k <- scf_asm_batch$kmer[opt_asm]

if(opt_k == max(scf_asm_batch$kmer)){
  write(paste('Submiting assembly from batch', batch, ' with kmer', opt_k+2, '; flags:', batch_flags), stderr())
  system(paste(asm_script, sp, opt_k+2, batch_flags))
}

if(opt_k == min(scf_asm_batch$kmer)){
  write(paste('Submiting assembly from batch', batch, ' with kmer', opt_k-2, '; flags:', batch_flags), stderr())
  system(paste(asm_script, sp, opt_k-2, batch_flags))
}

if(opt_k != min(scf_asm_batch$kmer) & opt_k != max(scf_asm_batch$kmer)){
    write(paste(sp, 'batch', batch, 'have optimal kmer', opt_k, '; flags:', batch_flags), stderr())
    write(paste('N50:', scf_asm_batch$N50[opt_asm],
                'NG50:', scf_asm_batch$NG50[opt_asm],
                '; total length:', scf_asm_batch$total_sum[opt_asm]), stderr())
    quit(status = 0)
}

quit(status = 1)
