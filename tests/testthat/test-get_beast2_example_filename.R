test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  basenames <- basename(get_beast2_example_filenames())
  expect_silent(get_beast2_example_filename(filename = basenames[1]))
  expect_silent(get_beast2_example_filename(basenames[length(basenames)]))
  expect_error(
    get_beast2_example_filename(filename = "abs.ent"),
    "Cannot find BEAST2 example file with name "
  )
})

test_that("give error when BEAST2 is not installed", {
  expect_error(
    get_beast2_example_filename(
      filename = "absent.xml",
      beast2_folder = "absent"
    ),
    "Cannot find BEAST2 example filenames in BEAST folder"
  )
})
