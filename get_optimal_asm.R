
# to load this file from anywhere
# source(paste0(Sys.getenv("TROOT"), '/scripts/R/get_optimal_asm.R'))

#asm <- read.table('stats/assemblies/1_Tdi_scfs.tsv', header= T)

get_asm_scores <- function(asm){
  NG50_scores <- asm$NG50 / max(asm$NG50)
  total_diff_scores <- 1 - abs(asm$diff_in_sum) / 1300000000


  asm$score <- rowMeans(cbind(NG50_scores, total_diff_scores), na.rm=TRUE)
  return(asm)
}

get_opt_asm <- function(asm){
  asm <- get_asm_scores(asm)
  return(which.max(asm$score))
}
