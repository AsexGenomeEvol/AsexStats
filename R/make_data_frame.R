#' Create a data.frame with defined variable names
#'
#' @param variables a vector of veriable names
#'
#' @export

make_data_frame <- function(variables){
  asm_template <- matrix(ncol = length(variables))
  colnames(asm_template) <- variables
  return(as.data.frame(asm_template)[FALSE,])
}
