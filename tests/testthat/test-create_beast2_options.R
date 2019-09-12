context("create_beast2_options")

test_that("use", {
  expect_silent(create_beast2_options())
})

test_that("BEAST2 working dir and folder for filenames must differ", {

  folder_name <- tempfile()

  # input_filename
  expect_error(
    create_beast2_options(
      input_filename = file.path(folder_name, "simple.xml"),
      beast2_working_dir = folder_name
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'input_filename'" # nolint
  )

  # output_log_filename
  expect_error(
    create_beast2_options(
      output_log_filename = file.path(folder_name, "simple.log"),
      beast2_working_dir = folder_name
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'output_log_filename'" # nolint
  )

  # output_trees_filenames
  expect_error(
    create_beast2_options(
      output_trees_filenames = file.path(folder_name, "simple.trees"),
      beast2_working_dir = folder_name
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'output_trees_filenames'" # nolint
  )

  # output_state_filename
  expect_error(
    create_beast2_options(
      output_state_filename = file.path(folder_name, "simple.xml.state"),
      beast2_working_dir = folder_name
    ),
    "'beast2_working_dir' must be a different folder than the folder of 'output_state_filename'" # nolint
  )

})
