test_that("use", {
  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )
  df <- beast2_options_to_table(beast2_options)
  expect_true(is.data.frame(df))
  expect_equal(ncol(df), 1)
})
