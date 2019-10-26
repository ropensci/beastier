test_that("use", {
  filename <- create_temp_input_filename()
  expect_true(!file.exists(filename))
})
