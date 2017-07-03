#' Plot sex legend
#'
#' This function plots a legend with sexual and sexual colours / symbols
#'
#' @param sp_data data frame with theta estimates
#'
#' @param min_cov sets treshold for coverage filtering,
#' only windows with cov in (min_cov * median, (1 + min_cov) * median) will be kept [0.5]
#'
#' @param filt_cov if to filter by coverage [True]
#'
#' @param window_size the minimal size of a window to keep [999]
#'
#' @param filt_window_size if to filter by window size [True]
#'
#' @export


filter_theta <- function(sp_data,
                         min_cov = 0.5, filt_cov = T,
                         window_size = 999, filt_window_size = T){
    # would be probably faster to do it using one call only,
    # this will copy the table in memory 4 times, but it probably does not really matter
    # at some point I would like to report filtering steps

    #nrow(sp_data)
    if(filt_cov){
        sp_data <- sp_data[sp_data$coverage > median(sp_data$coverage) * min_cov,]
        #nrow(sp_data)
        sp_data <- sp_data[sp_data$coverage < (median(sp_data$coverage) * (1 + min_cov)),]
        #nrow(sp_data)
    }
    if(filt_window_size){
        #nrow(sp_data)
        sp_data <- sp_data[(sp_data$end - sp_data$start) == window_size,]
    }
    sp_data <- sp_data[!is.na(sp_data$theta_MLE),]
    #nrow(sp_data)

    return(sp_data)
}
