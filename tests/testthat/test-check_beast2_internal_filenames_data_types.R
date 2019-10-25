test_that("use", {

  good_beast2_internal_filenames <- create_beast2_internal_filenames(
    create_beast2_options(
      input_filename = get_beastier_path("2_4.xml")
    )
  )
  expect_silent(
    check_beast2_internal_filenames_data_types(
      good_beast2_internal_filenames
    )
  )

  # Delete elements
  # input_filename_full
  beast2_internal_filenames <- good_beast2_internal_filenames
  beast2_internal_filenames$input_filename_full <- data.frame()
  expect_error(
    check_beast2_internal_filenames_data_types(
      beast2_internal_filenames
    ),
    "'input_filename_full' must be one character string"
  )

  # output_state_filename_full
  beast2_internal_filenames <- good_beast2_internal_filenames
  beast2_internal_filenames$output_state_filename_full <- data.frame()
  expect_error(
    check_beast2_internal_filenames_data_types(
      beast2_internal_filenames
    ),
    "'output_state_filename_full' must be one character string"
  )
})
