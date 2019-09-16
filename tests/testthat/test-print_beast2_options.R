test_that("use", {
  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )
  print_beast2_options(beast2_options)
})
