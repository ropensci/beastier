test_that("use", {
  if (!is_beast2_installed()) return()

  expect_silent(do_minimal_run())
})

test_that("no files are left undeleted", {
  beautier::check_empty_beautier_folder()
  check_empty_beastier_folder()
  beautier::clear_beautier_cache()
  clear_beastier_cache()
})
