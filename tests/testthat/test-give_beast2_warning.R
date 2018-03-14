context("give_beast2_warning")

test_that("use", {

  testthat::expect_true(
    give_beast2_warning(
      beautier:::get_beautier_paths("beast2_warning.xml")
    )
  )
  testthat::expect_false(
    give_beast2_warning(
      beautier:::get_beautier_paths("2_4.xml")
    )
  )
})
