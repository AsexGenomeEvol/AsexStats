load_thetas <- function(sp, ind, ref, window){
    file <- paste0('data/', sp, '/variant_calls/', ind, '/atlas/',
                   ind, '_to_', ref,
                   '_w',window,'_theta_estimates.txt')
    data <- read.table(file, header = T)
    # data <- filter_theta(data)
    return(data)
}
