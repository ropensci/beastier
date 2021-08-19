test_that("use", {
  folder_name <- dirname(beautier::get_beautier_tempfilename())
  unlink(folder_name, recursive = TRUE)
  expect_false(dir.exists(folder_name))
  create_beautier_tempfolder()
  expect_true(dir.exists(folder_name))
})
