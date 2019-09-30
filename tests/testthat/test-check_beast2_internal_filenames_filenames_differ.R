test_that("use", {
  good_beast2_internal_filenames <- create_beast2_internal_filenames(
    create_beast2_options(
      input_filename = get_beastier_path("2_4.xml")
    )
  )
  expect_silent(
    check_beast2_internal_filenames_filenames_differ(
      good_beast2_internal_filenames
    )
  )

  # input_filename_full
  beast2_internal_filenames <- good_beast2_internal_filenames
  beast2_internal_filenames$input_filename_full <-
    beast2_internal_filenames$actual_log_filename
  expect_error(
    check_beast2_internal_filenames_filenames_differ(
      beast2_internal_filenames
    ),
    "All BEAST2 internal filenames must be unique"
  )
})
