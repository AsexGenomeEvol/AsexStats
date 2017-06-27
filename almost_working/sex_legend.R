# requires asex_blue and sex_red colours

sex_legend <- function(pos = 'topright', cex = 1.3){
    legend("topright",
           legend=paste(c('sex', 'asex'), c("\u{2640}\u{2642}", "\u{2642}")),
           bty ="n",cex = cex, pch = 20, col = c(sex_red, asex_blue)) #,bg = "white"
}
