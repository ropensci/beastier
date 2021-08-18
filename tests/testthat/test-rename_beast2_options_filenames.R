test_that("replace dir from local to folder", {

  beast2_options <- create_beast2_options(
    input_filename = "my.fas",
    output_state_filename = "my_state.xml.state"
  )

  beast2_options <- rename_beast2_options_filenames(
    beast2_options = beast2_options,
    rename_fun = beautier::get_replace_dir_fun("/home/john")
  )

  expect_equal(beast2_options$input_filename, "/home/john/my.fas")
  expect_equal(
    beast2_options$output_state_filename,
    "/home/john/my_state.xml.state"
  )
})

test_that("rename dir from folder to folder", {

  beast2_options <- create_beast2_options()
  beast2_options$input_filename <- "/home/john/my.fas"
  beast2_options$output_state_filename <- "/home/john/my_state.xml.state"

  beast2_options <- rename_beast2_options_filenames(
    beast2_options = beast2_options,
    rename_fun = get_replace_dir_fun("/home/doe")
  )

  expect_equal(beast2_options$input_filename, "/home/doe/my.fas")
  expect_equal(
    beast2_options$output_state_filename,
    "/home/doe/my_state.xml.state"
  )
})


test_that("remove dir", {

  beast2_options <- create_beast2_options()
  beast2_options$input_filename <- "/home/john/my.fas"
  beast2_options$output_state_filename <- "/home/john/my_state.xml.state"

  beast2_options <- rename_beast2_options_filenames(
    beast2_options = beast2_options,
    rename_fun = get_remove_dir_fun()
  )

  expect_equal(beast2_options$input_filename, "my.fas")
  expect_equal(beast2_options$output_state_filename, "my_state.xml.state")
})

test_that("use", {

  expect_silent(
    rename_beast2_options_filenames(
      beast2_options = create_beast2_options(),
      rename_fun = get_remove_dir_fun()
    )
  )

  suppressMessages(get_replace_dir_fun())

  expect_silent(
    rename_beast2_options_filenames(
      beast2_options = create_beast2_options(),
      rename_fun = get_replace_dir_fun()
    )
  )
  expect_error(
    rename_beast2_options_filenames(
      beast2_options = create_beast2_options(),
      rename_fun = "nonsense"
    )
  )
  expect_silent(check_empty_beastier_folder())
})
