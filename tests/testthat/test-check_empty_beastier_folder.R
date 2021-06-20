test_that("tests should have cleaned up all their temp files", {
  expect_silent(check_empty_beastier_folder())
})

test_that("non-existing folder is empty", {
  expect_silent(check_empty_beastier_folder(get_beastier_tempfilename()))
})

test_that("folders are detected", {
  beastier_folder <- get_beastier_tempfilename()
  beastier_subfolder <- file.path(beastier_folder, "subfolder")
  expect_silent(check_empty_beastier_folder(beastier_folder))
  dir.create(beastier_subfolder, showWarnings = FALSE, recursive = TRUE)
  expect_error(check_empty_beastier_folder(beastier_folder))
  unlink(beastier_folder, recursive = TRUE)
  expect_silent(check_empty_beastier_folder(beastier_folder))
})

test_that("files are detected", {
  if (rappdirs::app_dir()$os == "win") return()

  dir.create(get_beastier_folder(), showWarnings = FALSE, recursive = TRUE)
  beastier_filename <- file.path(get_beastier_tempfilename())
  expect_silent(
    check_empty_beastier_folder(
      beastier_folder = get_beastier_folder()
    )
  )
  readr::write_lines(x = "irrelevant", file = beastier_filename)
  file.create(normalizePath(beastier_filename, mustWork = FALSE))
  expect_error(check_empty_beastier_folder(beastier_folder))
  file.remove(beastier_filename)
  expect_silent(check_empty_beastier_folder())
})
