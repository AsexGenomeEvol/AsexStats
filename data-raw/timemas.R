                   #ASEX    #SEX
timema_codes <- c("4_Tte", "4_Tbi",
                  "2_Tsi", "2_Tcm",
                  "1_Tdi", "1_Tps",
                  "3_Tms", "3_Tce",
                  "5_Tge", "5_Tpa")

timema_names <- c("T. tahoe", "T. bartmani",
                  "T. shepardi", "T. californicum",
                  "T. douglasi", "T. poppensis",
                  "T. monikensis", "T. cristinae",
                  "T. genevievae", "T. podura")

timema_labels <- c(expression(italic("T. tahoe")) , expression(italic("T. bartmani")),
                   expression(italic("T. shepardi")) , expression(italic("T. californicum")),
                   expression(italic("T. douglasi")) , expression(italic("T. poppensis")),
                   expression(italic("T. monikensis")) , expression(italic("T. cristinae")),
                   expression(italic("T. genevievae")) , expression(italic("T. podura")))

timema_short_labels <- c(expression(italic("Tte")) , expression(italic("Tbi")),
                         expression(italic("Tsi")) , expression(italic("Tcm")),
                         expression(italic("Tdi")) , expression(italic("Tps")),
                         expression(italic("Tms")) , expression(italic("Tce")),
                         expression(italic("Tge")) , expression(italic("Tpa")))

timema_latex_labels <- c("\\textcolor{asex_blue}{\\textit{tahoe}}","\\textcolor{sex_red}{\\textit{bartmani}}",
                         "\\textcolor{asex_blue}{\\textit{shepardi}}","\\textcolor{sex_red}{\\textit{californicum}}",
                         "\\textcolor{asex_blue}{\\textit{douglasi}}","\\textcolor{sex_red}{\\textit{poppensis}}",
                         "\\textcolor{asex_blue}{\\textit{monikensis}}","\\textcolor{sex_red}{\\textit{cristinae}}",
                         "\\textcolor{asex_blue}{\\textit{genevievae}}", "\\textcolor{sex_red}{\\textit{podura}}")

timema_optimal_kmer <- c(81, 81,
                         87, 83,
                         87, 83,
                         89, 83,
                         87, 65)

cols <- c('#a6bddb', '#fc9272',
          '#74a9cf', '#fb6a4a',
		  '#3690c0', '#ef3b2c',
		  '#0570b0', '#cb181d',
		  '#045a8d', '#a50f15')

timemas <- list(codes = timema_codes,
                names = timema_names,
                labels = timema_labels,
                short_labels = timema_short_labels,
                optimal_kmer = timema_optimal_kmer,
                cols = cols)

save(timemas, file = "data/timemas.rdata")
