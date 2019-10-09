test_that("use", {
  basenames <- basename(get_beast2_example_filenames())
  expect_silent(get_beast2_example_filename(filename = basenames[1]))
  expect_silent(get_beast2_example_filename(basenames[length(basenames)]))
  expect_error(
    get_beast2_example_filename(filename = "abs.ent"),
    "Cannot find BEAST2 example file with name "
  )
})
