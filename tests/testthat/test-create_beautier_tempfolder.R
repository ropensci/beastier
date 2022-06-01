test_that("use", {
  check_empty_beaustier_folders()

  folder_name <- dirname(beautier::get_beautier_tempfilename())
  unlink(folder_name, recursive = TRUE)
  expect_false(dir.exists(folder_name))
  beautier::create_beautier_tempfolder()
  expect_true(dir.exists(folder_name))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
