timema_pair_labels <- c(expression(italic("T. tahoe / T. barmani")),
                 expression(italic("T. monikensis / T. cristinae")),
                 expression(italic("T. douglasi / T. poppensis")),
                 expression(italic("T. shepardi / T. californicum")),
                 expression(italic("T. genevieve / T. podura")))

timema_JC_divergence <- c(0.77, 1.09, 1.17, 1.32, 1.88)


timema_pairs <- list(labels = timema_pair_labels,
                      JC_divergence = timema_JC_divergence)


save(timema_pairs, file = "data/timema_pairs.rdata")
