test_that("use", {
  filename <- create_temp_output_state_filename()
  expect_true(!file.exists(filename))
})
