test_that("use", {
  filenames <- get_beast2_example_filenames()
  expect_true(is.character(filenames))
  expect_true(length(filenames) > 10)
  expect_true(all(file.exists(filenames)))
})
