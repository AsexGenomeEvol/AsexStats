                   #ASEX    #SEX
timema_codes <- c("4_Tte", "4_Tbi",
                  "3_Tms", "3_Tce",
                  "1_Tdi", "1_Tps",
                  "2_Tsi", "2_Tcm",
                  "5_Tge", "5_Tpa")

timema_names <- c("T. tahoe", "T. barmani",
                  "T. monikensis", "T. cristinae",
                  "T. douglasi", "T. poppensis",
                  "T. shepardi", "T. californicum",
                  "T. genevieve", "T. podura")

timema_labels <- c(expression(italic("T. tahoe")) , expression(italic("T. barmani")),
                   expression(italic("T. monikensis")) , expression(italic("T. cristinae")),
                   expression(italic("T. douglasi")) , expression(italic("T. poppensis")),
                   expression(italic("T. shepardi")) , expression(italic("T. californicum")),
                   expression(italic("T. genevieve")) , expression(italic("T. podura")))

timema_short_labels <- c(expression(italic("Tte")) , expression(italic("Tbi")),
                         expression(italic("Tms")) , expression(italic("Tce")),
                         expression(italic("Tdi")) , expression(italic("Tps")),
                         expression(italic("Tsi")) , expression(italic("Tcm")),
                         expression(italic("Tge")) , expression(italic("Tpa")))

timemas <- list(codes = timema_codes,
                names = timema_names,
                labels = timema_labels,
                short_labels = timema_short_labels)


save(timemas, file = "data/timemas.rdata")
