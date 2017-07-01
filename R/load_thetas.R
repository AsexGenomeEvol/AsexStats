#' Load theta estimates
#'
#' This function allows you to load theta estimates from atlas
#' @param sp - species
#' @param ind - individual
#' @param ref - refrence version ('b3v05')
#' @param window size of estimates
#' @examples
#' Tdi_thetas <- load_thetas('1_Tdi', 'ref', 'b3v05', 100000)
#' @export

load_thetas <- function(sp, ind, ref, window){
    file <- paste0('data/', sp, '/variant_calls/', ind, '/atlas/',
                   ind, '_to_', ref, '_w', window, '_theta_estimates.txt')
    data <- read.table(file, header = T)
    # data <- filter_theta(data)
    return(data)
}
