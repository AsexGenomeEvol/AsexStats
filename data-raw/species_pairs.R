pair_labels <- c(expression(italic("T. tahoe / T. barmani")),
                 expression(italic("T. monikensis / T. cristinae")),
                 expression(italic("T. douglasi / T. poppensis")),
                 expression(italic("T. shepardi / T. californicum")),
                 expression(italic("T. genevieve / T. podura")))

divergence_times <- c(0.77, 1.09, 1.17, 1.32, 1.88)


species_pairs <- list(labels = pair_labels,
                      divergence_times = divergence_times)


save(species_pairs, file = "data/species_pairs.rdata")
