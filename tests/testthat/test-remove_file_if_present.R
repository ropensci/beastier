test_that("use, no file present", {
  check_empty_beaustier_folders()

  filename <- "abs.ent"
  expect_true(!file.exists(filename))
  expect_silent(remove_file_if_present(filename))
  expect_true(!file.exists(filename))

  check_empty_beaustier_folders()
})

test_that("use, file present", {
  check_empty_beaustier_folders()

  filename <- get_beastier_tempfilename()
  dir.create(dirname(filename), recursive = TRUE, showWarnings = FALSE)
  writeLines(text = "some irrelevant text", con = filename)
  expect_true(file.exists(filename))
  expect_silent(remove_file_if_present(filename))
  expect_true(!file.exists(filename))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
