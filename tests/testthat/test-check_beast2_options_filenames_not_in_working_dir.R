test_that("BEAST2 working dir and folder for filenames must differ", {

  good_beast2_options <- create_beast2_options()
  expect_silent(
    check_beast2_options_filenames_not_in_working_dir(
      good_beast2_options
    )
  )

  folder_name <- tempfile()

  # input_filename
  beast2_options <- good_beast2_options
  beast2_options$input_filename <- file.path(folder_name, "simple.xml")
  beast2_options$beast2_working_dir <- folder_name
  expect_error(
    check_beast2_options_filenames_not_in_working_dir(
      beast2_options
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'input_filename'" # nolint
  )

  # output_log_filename
  beast2_options <- good_beast2_options
  beast2_options$output_log_filename <- file.path(folder_name, "simple.log")
  beast2_options$beast2_working_dir <- folder_name
  expect_error(
    check_beast2_options_filenames_not_in_working_dir(
      beast2_options
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'output_log_filename'" # nolint
  )

  # output_trees_filenames
  beast2_options <- good_beast2_options
  beast2_options$output_trees_filenames <- file.path(folder_name, "simple.trees")
  beast2_options$beast2_working_dir <- folder_name
  expect_error(
    check_beast2_options_filenames_not_in_working_dir(
      beast2_options
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'output_trees_filenames'" # nolint
  )

  # output_state_filename
  beast2_options <- good_beast2_options
  beast2_options$output_state_filename <- file.path(folder_name, "simple.xml.state")
  beast2_options$beast2_working_dir <- folder_name
  expect_error(
    check_beast2_options_filenames_not_in_working_dir(
      beast2_options
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'output_state_filename'" # nolint
  )
})
