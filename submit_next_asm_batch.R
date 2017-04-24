source(paste0(Sys.getenv("TROOT"), '/scripts/R/get_optimal_asm.R'))
source(paste0(Sys.getenv("TROOT"), '/scripts/R/batch_subset.R'))

args <- commandArgs(trailingOnly=TRUE)

sp = args[1]
batch = as.numeric(args[2])

batch_flags <- c('--nomse --nompe --fewdata', '--nomse --nompe')[batch]
asm_script <- c('$TROOT/C_contig_assembly/2_SOAP.sh', '$TROOT/C_contig_assembly/2_SOAP.sh')[batch]

scf_file <- paste0('stats/assemblies/',sp,'_scfs.tsv')
scf_asm <- read.table(scf_file, header = T)

# take a subset of assemblies of specified batch;
# fction in scripts/R/batch_subset.R;
scf_asm_batch <- batch_subset(scf_asm, batch)

setwd(paste0('data/', sp, '/assembly/logs'))

if(nrow(scf_asm_batch) == 0){
  if(batch < 3){
    soap_asm <- scf_asm[scf_asm$soft == 'SOAP',]
    # function in scripts/R/get_opt_asm.R
    kmer <- soap_asm[get_opt_asm(soap_asm),'kmer']
  } else {
    write('Not implemented', stderr())
    quit(status = 1)
  }

  write(paste('Submiting assembly from batch', batch, ' with kmer', kmer, '; flags:', batch_flags), stderr())
  system(paste(asm_script, sp, kmer, batch_flags))
  quit(status = 1)
}

opt_asm <- get_opt_asm(scf_asm_batch)
opt_k <- scf_asm_batch$kmer[opt_asm]

if(opt_k == max(scf_asm_batch$kmer)){
  write(paste('Submiting assembly from batch', batch, ' with kmer', opt_k+2, '; flags:', batch_flags), stderr())
  system(paste(asm_script, sp, opt_k+2, batch_flags))
} else {
  if(opt_k == min(scf_asm_batch$kmer)){
    write(paste('Submiting assembly from batch', batch, ' with kmer', opt_k-2, '; flags:', batch_flags), stderr())
    system(paste(asm_script, sp, opt_k-2, batch_flags))
  }
}

if(opt_k != min(scf_asm_batch$kmer) & opt_k != max(scf_asm_batch$kmer)){
    write(paste(sp, 'batch', batch, 'have optimal kmer', opt_k, '; flags:', batch_flags), stderr())
    write(paste('N50:', scf_asm_batch$N50[opt_asm],
                'NG50:', scf_asm_batch$NG50[opt_asm],
                '; total length:', scf_asm_batch$total_sum[opt_asm]), stderr())
    cat(0)
    quit()
}

write('Not converged yet', stderr())
cat(1)
