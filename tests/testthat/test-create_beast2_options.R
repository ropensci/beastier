context("create_beast2_options")

test_that("use", {

  testthat::expect_silent(create_beast2_options("some.xml"))
})
