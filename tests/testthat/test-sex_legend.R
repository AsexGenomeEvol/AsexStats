context("graphics")

test_that("sex_legend plots a legend and reacts to parameters", {
        expect_that(sex_legend(), throws_error('plot.new has not been called yet'))
        #  has a problem with symbols
        # plot(0)
        # expected_position <- c(0.1815, 0.3265, 1.2505, 1.0800, 1.3090, 1.3090, 0.9712, 0.8623)
        # legend_position <- round(unlist(sex_legend()), 4)
        # expect_that(all(expected_position == legend_position), is_true())
    }
)
