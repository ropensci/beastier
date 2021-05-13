test_that("use", {
  if (!is_beast2_installed()) return()
  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )
  output_1 <- run_beast2_from_options(beast2_options)
  expect_true(file.exists(beast2_options$output_state_filename))
  output_2 <- continue_beast2(beast2_options)
  expect_true(file.exists(beast2_options$output_state_filename))
})
