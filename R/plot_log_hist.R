#' Plot log histogram with sex / asex overlaping data
#'
#' @param sex_data a vector of sex data (must be numeric)
#'
#' @param asex_data a vector of asex data
#'
#' @param xlim [from data], xlab ['Scafold size'], cex.axis [2], cex.lab [1.6] inherited form \code{plot}
#'
#' @param breaks [80] inherited from \code{hist}
#'
#' @param barwidth width of histogram bars (I have not managed to make it perfectly automated) [13]
#'
#' @param axes logical if to plot axis [T]
#'
#' @export

plot_log_hist <- function(sex_data, asex_data, xlim = NA,
                          xlab = 'Scafold size', breaks = 80, barwidth = 13,
                          noborder = F, axes = T,
                          cex.axis = 2, cex.lab = 1.6){

  cont_hist <- hist(sex_data, plot = F, breaks = breaks)
  cont_hist2 <- hist(asex_data, plot = F, breaks = breaks)

  if(noborder){
    par(mar=c(2, 4.1, 2.5, 1.3) + 0.5)
  }

  if(any(is.na(xlim))){
      xlim <- c(min(cont_hist$mids, cont_hist2$mids),
                max(cont_hist$mids, cont_hist2$mids))
  }

  plot(log10(cont_hist$counts) ~ cont_hist$mids,
       type = 'h',
       lwd = barwidth,
       xlab = xlab,
       ylab = parse(text=paste("log[10]", "*Frequency")),
       xlim = xlim,
       ylim = c(0, max(log10(cont_hist$counts),log10(cont_hist2$counts))),
       col = sex_red,
       cex.axis = cex.axis,
       cex.lab = cex.lab,
       las = 1,
       axes = axes,
       bty = "n")

  lines(log10(cont_hist2$counts) ~ cont_hist2$mids,
       type = 'h',
       lwd = barwidth, col = asex_blue)
}
