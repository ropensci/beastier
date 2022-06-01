test_that("use", {
  check_empty_beaustier_folders()

  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )

  # From https://stackoverflow.com/a/2501913
  if (rappdirs::app_dir()$os == "win") {
    sink("NUL")
  } else {
    sink("/dev/null")
  }
  print_beast2_options(beast2_options)
  sink()

  check_empty_beaustier_folders()
})
