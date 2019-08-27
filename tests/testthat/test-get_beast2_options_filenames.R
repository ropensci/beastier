test_that("use", {

  beast2_options <- beastier::create_beast2_options()
  filenames <- get_beast2_options_filenames(beast2_options)
  expect_true(beast2_options$input_filename %in% filenames)
  expect_true(beast2_options$output_log_filename %in% filenames)
  expect_true(beast2_options$output_trees_filenames %in% filenames)
  expect_true(beast2_options$output_state_filename %in% filenames)

})
