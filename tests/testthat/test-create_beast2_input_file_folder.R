test_that("use", {
  check_empty_beaustier_folders()

  beast2_options <- create_beast2_options()
  folder_name <- dirname(beast2_options$input_filename)
  unlink(folder_name, recursive = TRUE)
  expect_false(dir.exists(folder_name))
  create_beastier_tempfolder()
  expect_true(dir.exists(folder_name))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
