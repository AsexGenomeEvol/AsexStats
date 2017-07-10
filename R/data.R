#' Timema species pairs
#'
#' a useful variables and information related to species pairs :
#' \itemize{
#'   \item `labels` - a vector of expressions;
#'   \item `JK-divergence` - divergences between pairs are calculated from transcriptomes;
#' }
#'
#' @format a list
#' (pairs are sorted by divergence of Timema pairs)
#'
#' @examples
#' timema_pairs$labels # returns a vector of pair labels
"timema_pairs"

#' Timema info
#'
#' a useful variables and information related to Timema species :
#' \itemize{
#'   \item `timema_codes`
#'   \item `timema_names`
#'   \item `labels` - a vector of expressions;
#'   \item `short_labels`
#' }
#'
#' @format a list
#' interleaved asexual and sexual sister species with pairs sorted by divergences
#'
#' @examples
#' timemas$labels # returns a vector of formated timema labels
"timemas"

#' A blue colour used for asexual species
#'
#' literally
#' asex_blue <- "#92C5DECD"
#' where first 6 hexadecimal digits after # are RGB intensities
#' and the last two hexadecimal digits is transparency (alpha)
#'
#' @format string
"asex_blue"

#' A red colour used for sexual species
#'
#' literally
#' sex_red <- "#D6604DED"
#' where first 6 hexadecimal digits after # are RGB intensities
#' and the last two hexadecimal digits is transparency (alpha)
#'
#' @format string
"sex_red"
