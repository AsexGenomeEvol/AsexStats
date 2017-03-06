# Create a data.frame
# using column names defined by a string vector

make_data_frame <- function(variables){
  asm_template <- matrix(ncol = length(variables))
  colnames(asm_template) <- variables
  return(as.data.frame(asm_template)[FALSE,])
}
