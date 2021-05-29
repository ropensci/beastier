test_that("use", {
  expect_silent(check_can_create_file("local_usually_works"))

  expect_error(
    check_can_create_file("/root_usually_fails"),
    "Cannot create a file at location"
  )

  get_beastier_tempfilename <- get_beastier_tempfilename()
  writeLines(text = "irreleveant", con = get_beastier_tempfilename)

  expect_error(
    check_can_create_file(get_beastier_tempfilename, overwrite = FALSE),
    "Cannot check if a file can be created if the desired file already exists"
  )

  expect_silent(
    check_can_create_file(get_beastier_tempfilename, overwrite = TRUE)
  )
})
