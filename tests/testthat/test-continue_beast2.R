test_that("use", {
  skip("WIP")
  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )

  output_1 <- run_beast2_from_options(beast2_options)
  output_2 <- continue_beast2(beast2_options)
})
