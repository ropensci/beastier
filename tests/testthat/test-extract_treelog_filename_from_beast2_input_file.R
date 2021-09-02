test_that("all is fine", {
  beast2_input_filename <- get_beastier_tempfilename()
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_beautier_path("test_output_0.fas"),
    output_filename = beast2_input_filename
  )
  expect_true(file.exists(beast2_input_filename))
  expect_equal(
    "test_output_0.trees",
    extract_treelog_filename_from_beast2_input_file(
      input_filename = beast2_input_filename
    )
  )
  file.remove(beast2_input_filename)
  check_empty_beastier_folder()
  # beastierinstall::clear_beautier_cache(); beastierinstall::clear_beastier_cache() # nolint
})
