test_that("use", {
  expect_message(beastier_report())
})

test_that("no files are left undeleted", {
  beautier::check_empty_beautier_folder()
  beastier::check_empty_beastier_folder()
})
