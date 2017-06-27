graphicsPATH <- '/Volumes/dump/pictures/pool/ngs/timema/'
sbired <- rgb(255 / 255,36 / 255,31 / 255)
sbiredT <- rgb(255 / 255,36 / 255,31 / 255, alpha = 0.5)
illublueT <- rgb(6 / 255,243 / 255,255 / 255, alpha = 0.5)

source('/Volumes/dump/scripts/R/genomics/getNX.R')
source('/Volumes/dump/scripts/R/genomics/getN50.R')
source('/Volumes/dump/scripts/R/start_up/table_print.R')

path <- ''
files <- dir(path)
sp <- substr(files, 3, 5)
sp_labels <- substr(files, 1, 5)
files <- paste0(path,files)

for(i in 1:10){
  assign(sp[i], read.csv(files[i], header = F)$V1)
}

library(RColorBrewer)
pal <- brewer.pal(10, 'RdYlBu')
#display.brewer.pal(10, 'RdYlGn')
SEXpal <- pal[1:5]
ASEXpal <- pal[10:6]

timemaNX <- data.frame(longest =  numeric(0), N1 =  numeric(0), N5 =  numeric(0), N10 = numeric(0), N20 =  numeric(0), N30 =  numeric(0),  N50 =  numeric(0))
for(timema in sp){
  lengths <- get(timema)
  timemaNX[nrow(timemaNX)+1,] <- c(max(lengths), getNX(lengths, c(1,5,10,20,30,50), 1.3e9))
}
rownames(timemaNX) <- sp_labels
timemaNX[c(1,2,4,3,6,5,8,7,9,10),]

sp <- sp[c(1,2,4,3,6,5,8,7,9,10)]
sp_labels <- sp_labels[c(1,2,4,3,6,5,8,7,9,10)]


pdf('timema_NX_graph.pdf')

X <- seq(0,100, by = 0.1)
NX <- getNX(Tdi, X, 1.3e9)
plot(NX ~ X, type = 'l', main = 'timema', ylim = c(1, max(Tms)), col = ASEXpal[1])

col_index = 2
for(i in seq(3,10,by=2)){
  NX <- getNX(get(sp[i]), X, 1.3e9)
  lines(NX ~ X, type = 'l', col = ASEXpal[col_index])
  col_index = col_index + 1
}

col_index = 1
for(i in seq(2,10,by=2)){
  NX <- getNX(get(sp[i]), X, 1.3e9)
  lines(NX ~ X, type = 'l', col = SEXpal[col_index])
  col_index = col_index + 1
}

legend('topright', pch = 20, col = pal[c(10,1,9,2,8,3,7,4,6,5)], legend = sp_labels)

dev.off()
