#' Split a string by defined character and return unlisted vector of substrings
#'
#' @param s a string to split
#'
#' @param split a character used to split [default split = '=']
#'
#' @export

ssplit <- function(s, split = '='){
    unlist(strsplit(s, split = split))
}
