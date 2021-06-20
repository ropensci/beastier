test_that("use", {
  expect_silent(create_beast2_options())
})

# BEAST2 working dir and folder for filenames must differ
# is tested by test-check_beast2_options_filenames_not_in_working_dir.R

test_that("deprecated variables", {

  expect_error(
    create_beast2_options(
      output_log_filename = "deprecated"
    ),
    "'output_log_filename' is deprecated, it is stored in the BEAST2 XML"
  )

  expect_error(
    create_beast2_options(
      output_trees_filenames = "deprecated"
    ),
    "'output_trees_filenames' is deprecated, it is stored in the BEAST2 XML"
  )
  expect_error(
    create_beast2_options(
      beast2_working_dir = "deprecated"
    ),
    "'beast2_working_dir' is deprecated"
  )
})
