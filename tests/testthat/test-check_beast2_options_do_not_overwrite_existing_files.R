test_that("may overwrite", {
  # When the BEAST2 options are allowed to overwrite files,
  # then nothing needs to be stopped
  beast2_options <- create_beast2_options()
  expect_equal(beast2_options$overwrite, TRUE)
  expect_silent(
    check_beast2_options_do_not_overwrite_existing_files(beast2_options)
  )
})

test_that("may not overwrite on absent file", {
  # When the BEAST2 options are not allowed to overwrite files,
  # and the state filename does not exists,
  # then nothing needs to be stopped
  beast2_options <- create_beast2_options()
  beast2_options$overwrite <- FALSE
  expect_equal(file.exists(beast2_options$output_state_filename), FALSE)
  expect_equal(beast2_options$overwrite, FALSE)
  expect_silent(
    check_beast2_options_do_not_overwrite_existing_files(beast2_options)
  )
})

test_that("may not overwrite on file that exists", {
  # When the BEAST2 options are not allowed to overwrite files,
  # and the state filename does not exists,
  # then nothing needs to be stopped
  beast2_options <- create_beast2_options()
  beast2_options$overwrite <- FALSE
  expect_equal(file.exists(beast2_options$output_state_filename), FALSE)
  dir.create(
    dirname(
      beast2_options$output_state_filename
    ),
    showWarnings = FALSE,
    recursive = TRUE
  )
  file.create(beast2_options$output_state_filename)
  expect_equal(file.exists(beast2_options$output_state_filename), TRUE)
  expect_equal(beast2_options$overwrite, FALSE)
  expect_error(
    check_beast2_options_do_not_overwrite_existing_files(beast2_options),
    "Will not overwrite"
  )
  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
