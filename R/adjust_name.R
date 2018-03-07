#' Adjust a string bu a symbol, motivated by fixing names of linkage groups for grepping (lg1 would grep lg10 as well)
#'
#' @param name a name to adjust
#'
#' @param length a length of string to be extended by a symbol
#'
#' @param symbol for extension. Default : '_'
#'
#' @export

adjust_name <- function(name, length, symbol = '_'){
    ifelse(nchar(name) == length, paste0(name, symbol), name)
}
