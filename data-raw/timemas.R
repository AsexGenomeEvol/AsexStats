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

timema_latex_labels <- c("\\textcolor{asex_blue}{\\textit{tahoe}}","\\textcolor{sex_red}{\\textit{bartmani}}",
                         "\\textcolor{asex_blue}{\\textit{monikensis}}","\\textcolor{sex_red}{\\textit{cristinae}}",
                         "\\textcolor{asex_blue}{\\textit{douglasi}}","\\textcolor{sex_red}{\\textit{poppensis}}",
                         "\\textcolor{asex_blue}{\\textit{shepardi}}","\\textcolor{sex_red}{\\textit{californicum}}",
                         "\\textcolor{asex_blue}{\\textit{genevievae}}", "\\textcolor{sex_red}{\\textit{podura}}")

timema_optimal_kmer <- c(81, 81,
                         89, 83,
                         87, 83,
                         87, 83,
                         87, 65)

timemas <- list(codes = timema_codes,
                names = timema_names,
                labels = timema_labels,
                short_labels = timema_short_labels,
                optimal_kmer = timema_optimal_kmer)


save(timemas, file = "data/timemas.rdata")
