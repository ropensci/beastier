test_that("minimal use", {
  expect_silent(is_beast2_installed())

  expect_silent(beautier::check_empty_beautier_folder())
  expect_silent(beastier::check_empty_beastier_folder())
  # beastierinstall::clear_beautier_cache(); beastierinstall::clear_beastier_cache() # nolint
})
