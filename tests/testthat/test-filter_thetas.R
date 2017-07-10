context("theta operations")

theta_data <- read.csv('theta_sample.csv')

test_that("filter_thetas removes correct number of rows", {
        expect_that(nrow(filter_thetas(theta_data)), equals(29))
        expect_that(nrow(filter_thetas(theta_data, filt_cov = F, window_size = 99999)), equals(28))
        expect_that(nrow(filter_thetas(theta_data, filt_cov = F, filt_window_size = F)), equals(30))
    }
)
