test_that("use", {
  expect_silent(check_can_create_file("local_usually_works"))

  expect_error(
    check_can_create_file("/root_usually_fails"),
    "Cannot create a file at location"
  )

  tempfile <- tempfile()
  writeLines(text = "irreleveant", con = tempfile)
  expect_error(
    check_can_create_file(tempfile),
    "Cannot check if a file can be created if the desired file already exists"
  )
})
