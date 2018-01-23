context("save_lines")

test_that("save_lines: use", {
  filename <- tempfile()
  lines <- c("Hello", "world")
  beastier:::save_lines(
    filename = filename,
    lines = lines
  )
  testthat::expect_equal(file.exists(filename), TRUE)

  # Remove temporary file
  has_removed <- file.remove(filename)
  testthat::expect_equal(file.exists(filename), FALSE)
})
