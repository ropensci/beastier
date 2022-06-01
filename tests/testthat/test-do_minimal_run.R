test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  expect_silent(do_minimal_run())

  check_empty_beaustier_folders()
})
