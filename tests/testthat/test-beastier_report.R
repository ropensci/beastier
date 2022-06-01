test_that("use", {
  check_empty_beaustier_folders()

  expect_message(beastier_report())
  expect_message(beastier_report(beast2_folder = "absent"))

  check_empty_beaustier_folders()
})
