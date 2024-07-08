test_that("use", {
  expect_silent(
    check_input_filename(get_beastier_path("beast2_example_output.log"))
  )
})
