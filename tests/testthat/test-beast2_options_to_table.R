test_that("use", {
  check_empty_beaustier_folders()

  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )
  t <- beast2_options_to_table(beast2_options)
  expect_true(tibble::is_tibble(t))
  expect_equal(ncol(t), 2)

  check_empty_beaustier_folders()
})
