context("create_beast2_options")

test_that("use", {
  expect_silent(create_beast2_options())
})

# BEAST2 working dir and folder for filenames must differ
# is tested by test-check_beast2_options_filenames_not_in_working_dir.R
