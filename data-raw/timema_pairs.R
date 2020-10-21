timema_pair_labels <- c(expression(italic("T. tahoe / T. bartmani")),
                        expression(italic("T. shepardi / T. californicum")),
                        expression(italic("T. monikensis / T. cristinae")),
                        expression(italic("T. douglasi / T. poppensis")),
                        expression(italic("T. genevievae / T. podura")))

timema_JC_divergence_mean <- c(0.77, 1.32, 1.09, 1.17, 1.88)
timema_JC_divergence_median <- c(0.24, 0.36, 0.46, 0.38, 0.72)
timema_divergences <- c(0.00166475, 0.00228019, 0.00275862, 0.00343811, 0.00559974)

timema_pairs <- list(labels = timema_pair_labels,
                      JC_median_divergence = timema_JC_divergence_median,
                      JC_mean_divergence = timema_JC_divergence_mean,
                      phylo_divergences = timema_divergences)

save(timema_pairs, file = "data/timema_pairs.rdata")
