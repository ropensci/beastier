test_that("use", {
  check_empty_beaustier_folders()

  filename <- create_temp_input_filename()
  expect_true(!file.exists(filename))

  check_empty_beaustier_folders()
})
