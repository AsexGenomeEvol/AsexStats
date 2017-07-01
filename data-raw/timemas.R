                   #ASEX    #SEX
timema_codes <- c("1_Tdi", "1_Tps",
                  "2_Tsi", "2_Tcm",
                  "3_Tms", "3_Tce",
                  "4_Tte", "4_Tbi",
                  "5_Tge", "5_Tpa")

timema_names <- c("T. douglasi", "T. poppensis",
                  "T. shepardi", "T. californicum",
                   "T. monikensis", "T. cristinae",
                   "T. tahoe", "T. barmani",
                   "T. genevieve", "T. podura")

timema_labels <- c(expression(italic("T. douglasi")) , expression(italic("T. poppensis")),
                   expression(italic("T. shepardi")) , expression(italic("T. californicum")),
                   expression(italic("T. monikensis")) , expression(italic("T. cristinae")),
                   expression(italic("T. tahoe")) , expression(italic("T. barmani")),
                   expression(italic("T. genevieve")) , expression(italic("T. podura")))

timemas <- list(codes = timema_codes,
                names = timema_names,
                labels = timema_labels)


save(timemas, file = "data/timemas.rdata")
