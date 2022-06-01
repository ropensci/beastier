test_that("minimal use", {
  expect_silent(check_empty_beaustier_folders())

  expect_silent(is_beast2_installed())

  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())

  expect_silent(check_empty_beaustier_folders())
})
