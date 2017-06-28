filter_theta <- function(sp_data, min_cov = 0.5, window_size = 999){
    # would be probably faster to do it using one call only,
    # this will copy the table in memory 4 times, but it probably does not really matter
    # at some point I would like to report filtering steps

    #nrow(sp_data)
    sp_data <- sp_data[(sp_data$end - sp_data$start) == window_size,]
    #nrow(sp_data)
    sp_data <- sp_data[sp_data$coverage > median(sp_data$coverage) * min_cov,]
    #nrow(sp_data)
    sp_data <- sp_data[sp_data$coverage < (median(sp_data$coverage) * (1 + min_cov)),]
    #nrow(sp_data)
    sp_data <- sp_data[!is.na(sp_data$theta_MLE),]
    #nrow(sp_data)

    return(sp_data)
}
