test_that("use", {
  check_empty_beaustier_folders()

  folder_name <- dirname(get_beastier_tempfilename())
  unlink(folder_name, recursive = TRUE)
  expect_false(dir.exists(folder_name))
  create_beastier_tempfolder()
  expect_true(dir.exists(folder_name))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
