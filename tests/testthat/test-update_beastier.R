test_that("should be silent", {
  update_beastier()

  expect_silent(update_beastier())
})
