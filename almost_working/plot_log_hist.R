plot_log_hist <- function(sex_data, asex_data, xlim = NA,
                          xlab = 'Scafold size', breaks = 80, barwidth = 13,
                          col = c("#D6604DED", "#92C5DECD"), noborder = F, axes = T){
  sex_red <- col[1]
  asex_blue <- col[2]

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
       cex.axis = 2,
       cex.lab = 1.6,
       las = 1,
       axes = axes,
       bty = "n")

  lines(log10(cont_hist2$counts) ~ cont_hist2$mids,
       type = 'h',
       lwd = barwidth, col = asex_blue)
}
