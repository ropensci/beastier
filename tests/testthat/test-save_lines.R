test_that("use", {
  filename <- get_beastier_tempfilename()
  lines <- c("Hello", "world")
  save_lines(
    filename = filename,
    lines = lines
  )
  expect_equal(file.exists(filename), TRUE)

  # Remove temporary file
  has_removed <- file.remove(filename)
  expect_equal(file.exists(filename), FALSE)
})
