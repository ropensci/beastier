test_that("minimal use", {
  check_empty_beaustier_folders()

  expect_silent(is_beast2_installed())

  check_empty_beaustier_folders()
})
