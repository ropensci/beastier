test_that("extract", {
  check_empty_beaustier_folders()

  beast2_input_filename <- get_beastier_tempfilename()
  screenlog_filename <- get_beastier_tempfilename("screenlog")
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_beautier_path("test_output_0.fas"),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        screenlog = create_screenlog(filename = screenlog_filename)
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_equal(
    extract_screenlog_filename_from_beast2_input_file(
      input_filename = beast2_input_filename
    ),
    screenlog_filename
  )
  file.remove(beast2_input_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  # On Windows, this test will pass
  skip_on_os(os = "windows")

  check_empty_beaustier_folders()

  beast2_input_filename <- get_beastier_tempfilename()
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_beautier_path("test_output_0.fas"),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        screenlog = create_screenlog(filename = "/cannot_write_to_root.trees")
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_error(
    check_can_create_screenlog_file(beast2_options),
    "Cannot create screenlog file"
  )
  file.remove(beast2_input_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
