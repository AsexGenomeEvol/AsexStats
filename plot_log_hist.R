plot_log_hist <- function(sex_data, asex_data, xlab = 'Scafold size', breaks = 80, barwidth = 13){
  sex_red <- "#D6604DED"
  asex_blue <- "#92C5DECD"

  cont_hist <- hist(sex_data, plot = F, breaks = breaks)
  cont_hist2 <- hist(asex_data, plot = F, breaks = breaks)

  #par(mar=c(2, 4.1, 2.5, 1.3) + 0.5)
  plot(log10(cont_hist$counts) ~ cont_hist$mids,
       type = 'h',
       lwd = barwidth,
       xlab = xlab,
       ylab = parse(text=paste("log[10]", "*Frequency")),
       xlim = c(min(cont_hist$mids, cont_hist2$mids),
                max(cont_hist$mids, cont_hist2$mids)),
       ylim = c(0, max(log10(cont_hist$counts),log10(cont_hist2$counts))),
       col = sex_red,
       cex.axis = 2,
       cex.lab = 1.6,
       las = 1,
       bty = "n")

  lines(log10(cont_hist2$counts) ~ cont_hist2$mids,
       type = 'h',
       lwd = barwidth, col = asex_blue)
}
