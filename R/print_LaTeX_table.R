#' print LaTeX table
#'
#' This function prints a table that can be directly copy pasted into LaTeX
#'
#' @param tabletoprint the table to be printed for LaTeX
#'
#' @param alignment the aligment for the columns of the table (either vector of alignments or a single letter that will be used for all)
#'
#' @export

print_LaTeX_table <- function(tabletoprint, alignment = 'c'){
  if( length(alignment) == 1){
    alignment <- paste(rep(alignment,ncol(tabletoprint)), collapse = ' ')
  }
  cat(paste('\\begin{tabular}{', alignment ,'}\n'))
  cat(paste(colnames(tabletoprint),collapse = " & "),'\\\\\n')
  cat('\\hline\n')
  topr <- apply(tabletoprint, 1, paste, collapse = ' & ')
  for(rw in 1:length(topr)){
    cat(topr[rw],'\\\\\n')
  }
  cat('\\end{tabular}\n')
}
