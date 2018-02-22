context("get_default_beast2_folder")

test_that("use", {

  testthat::expect_equal(
    get_default_beast2_folder(),
    "~/Programs/beast"
  )
})
