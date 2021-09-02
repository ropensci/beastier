test_that("use", {
  expect_message(beastier_report())
  expect_message(beastier_report(beast2_folder = "absent"))
  beautier::check_empty_beautier_folder()
  beastier::check_empty_beastier_folder()
  # beastierinstall::clear_beautier_cache(); beastierinstall::clear_beastier_cache() # nolint
})
