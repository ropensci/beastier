test_that("use", {
  if (!is_beast2_installed()) return()
  filenames <- get_beast2_example_filenames()
  expect_true(is.character(filenames))
  expect_true(length(filenames) > 10)
  expect_true(all(file.exists(filenames)))
})

test_that("give error when BEAST2 is not installed", {
  expect_error(
    get_beast2_example_filenames(
      beast2_folder = "absent"
    ),
    "Cannot find BEAST2 example filenames in BEAST folder"
  )
})
