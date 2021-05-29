test_that("use", {
  expect_silent(check_can_create_file("local_usually_works"))

  expect_error(
    check_can_create_file("/root_usually_fails"),
    "Cannot create a file at location"
  )

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

  expect_silent(
    check_can_create_file(beastier_tempfilename, overwrite = TRUE)
  )
})
