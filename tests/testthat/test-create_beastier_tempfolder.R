test_that("use", {
  folder_name <- dirname(beastier::get_beastier_tempfilename())
  unlink(folder_name, recursive = TRUE)
  expect_false(dir.exists(folder_name))
  create_beastier_tempfolder()
  expect_true(dir.exists(folder_name))
})
