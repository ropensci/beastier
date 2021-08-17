test_that("minimal use", {
  expect_silent(is_beast2_installed())

  expect_silent(check_empty_beastier_folder())
})
