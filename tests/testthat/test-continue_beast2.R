test_that("minimal use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )
  output_1 <- run_beast2_from_options(beast2_options)
  expect_true(file.exists(beast2_options$output_state_filename))
  output_2 <- continue_beast2(beast2_options)
  expect_true(file.exists(beast2_options$output_state_filename))
  file.remove(beast2_options$output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("minimal use with verbose", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  sink_tempfile <- beautier::get_beautier_tempfilename()
  dir.create(dirname(sink_tempfile), showWarnings = FALSE, recursive = TRUE)
  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml"),
    verbose = TRUE
  )
  sink(sink_tempfile)
  suppressMessages({
    output_1 <- run_beast2_from_options(beast2_options)
    output_2 <- continue_beast2(beast2_options)
  })
  sink()
  file.remove(sink_tempfile)
  file.remove(beast2_options$output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("longer trace", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  # Prevent check_can_create_treelog_file problem
  do_skip <- TRUE
  tryCatch({
    inference_model <- create_test_inference_model()
    check_can_create_file(inference_model$mcmc$screenlog$filename)
    stop("x")
    do_skip <- FALSE
  }, error = function(e) {} # nolint no worries
  )
  if (do_skip) skip("test-continue_beast2.R: longer trace")


  beast2_input_filename <- get_beastier_tempfilename()
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_beautier_path("test_output_0.fas"),
    output_filename = beast2_input_filename,
    inference_model = inference_model
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  run_beast2_from_options(beast2_options)
  results <- tracerer::parse_beast_output_files(
    log_filename = inference_model$mcmc$tracelog$filename,
    trees_filenames = inference_model$mcmc$treelog$filename,
    state_filename = beast2_options$output_state_filename
  )
  continue_beast2(beast2_options)
  results_after <- tracerer::parse_beast_output_files(
    log_filename = inference_model$mcmc$tracelog$filename,
    trees_filenames = inference_model$mcmc$treelog$filename,
    state_filename = beast2_options$output_state_filename
  )
  expect_true(nrow(results$estimates) < nrow(results_after$estimates))
  file.remove(beast2_options$input_filename)
  file.remove(beast2_options$output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
