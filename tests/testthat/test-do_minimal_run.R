test_that("use", {
  if (!is_beast2_installed()) return()

  expect_silent(do_minimal_run())
})
