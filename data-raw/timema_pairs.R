timema_pair_labels <- c(expression(italic("T. tahoe / T. bartmani")),
                        expression(italic("T. shepardi / T. californicum")),
                        expression(italic("T. douglasi / T. poppensis")),
                        expression(italic("T. monikensis / T. cristinae")),
                        expression(italic("T. genevieve / T. podura")))

timema_JC_divergence_mean <- c(0.77, 1.32, 1.17, 1.09, 1.88)
timema_JC_divergence_median <- c(0.24, 0.36, 0.38, 0.46, 0.72)

timema_pairs <- list(labels = timema_pair_labels,
                      JC_median_divergence = timema_JC_divergence_median,
                      JC_mean_divergence = timema_JC_divergence_mean)


save(timema_pairs, file = "data/timema_pairs.rdata")
