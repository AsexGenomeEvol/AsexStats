#' Plot
#'
#' This function plots a legend with sexual and sexual colours / symbols
#'
#' @param pos position of the legend ['topright']
#'
#' @param cex the size of legend [1.3]
#'
#' @export

sex_legend <- function(pos = 'topright', cex = 1.3){
    legend("topright",
           legend=paste(c('sex', 'asex'), c("\u{2640}\u{2642}", "\u{2640}")),
           bty ="n",cex = cex, pch = 20, col = c(sex_red, asex_blue)) #,bg = "white"
}
