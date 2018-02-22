context("get_default_beast2_jar_path")

test_that("use", {

  testthat::expect_equal(
    get_default_beast2_jar_path(),
    "~/Programs/beast/lib/beast.jar"
  )

})
