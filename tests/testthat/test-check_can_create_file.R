test_that("create local filename", {
  expect_silent(check_can_create_file("local_usually_works"))
})

test_that("can create file in root", {
  expect_error(
    check_can_create_file("/root_usually_fails"),
    "Cannot create a file at location"
  )
})

test_that("cannot create file without overwrite", {
  beastier_tempfilename <- get_beastier_tempfilename()
  dir.create(
    dirname(beastier_tempfilename),
    showWarnings = FALSE,
    recursive = TRUE
  )
  writeLines(text = "irrelevant", con = beastier_tempfilename)

  expect_error(
    check_can_create_file(beastier_tempfilename, overwrite = FALSE),
    "Cannot check if a file can be created if the desired file already exists"
  )
  unlink(dirname(beastier_tempfilename), recursive = TRUE)
  expect_silent(check_empty_beastier_folder())
})

test_that("can create file without overwrite", {
  beastier_tempfilename <- get_beastier_tempfilename()
  dir.create(
    dirname(beastier_tempfilename),
    showWarnings = FALSE,
    recursive = TRUE
  )
  writeLines(text = "irrelevant", con = beastier_tempfilename)
  expect_silent(
    check_can_create_file(beastier_tempfilename, overwrite = TRUE)
  )
  unlink(dirname(beastier_tempfilename), recursive = TRUE)
  expect_silent(check_empty_beastier_folder())
})

test_that("can create file in sub-sub-sub folder", {
  beastier_tempfilename <- file.path(
    get_beastier_tempfilename(), "sub", "sub", "filename.txt"
  )
  filename <- beastier_tempfilename
  expect_silent(
    check_can_create_file(filename = beastier_tempfilename)
  )
  expect_false(file.exists(beastier_tempfilename))
  expect_silent(check_empty_beastier_folder())
})
