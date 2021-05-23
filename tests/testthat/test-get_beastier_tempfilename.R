test_that("use", {
  expect_silent(get_beastier_tempfilename())
  expect_silent(get_beastier_tempfilename(pattern = "test"))
  expect_silent(get_beastier_tempfilename(fileext = ".xml"))
})
