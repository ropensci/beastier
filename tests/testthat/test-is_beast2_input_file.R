context("is_beast2_input_file")

test_that("beast2_example_output.log is not a valid BEAST2 input file", {

  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("beast2_example_output.log")
  is_ok <- NULL

  expect_output(
    is_ok <- beastier::is_beast2_input_file(
      filename,
      verbose = TRUE
    )
  )

  testthat::expect_false(is_ok)
})

test_that("beast2_example_output.trees is not a valid BEAST2 input file", {

  # Gives a status error
  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("beast2_example_output.trees")

  is_ok <- NULL
  expect_output(
    is_ok <- beastier::is_beast2_input_file(filename, verbose = TRUE)
  )
  testthat::expect_false(is_ok)

})

test_that("anthus_2_4.xml is valid, from bin", {

  if (!is_on_ci()) return()

  # The .exe will always show a pop-up
  if (rappdirs::app_dir()$os == "win") return()

  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("anthus_2_4.xml")
  testit::assert(file.exists(filename))
  expect_true(
    beastier::is_beast2_input_file(
      filename,
      beast2_path = get_default_beast2_bin_path()
    )
  )
})

test_that("anthus_2_4.xml is valid, from jar", {

  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("anthus_2_4.xml")
  expect_true(file.exists(filename))
  expect_true(
    beastier::is_beast2_input_file(
      filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )
})

test_that("abuse", {

  testthat::expect_error(
    beastier::is_beast2_input_file("abs.ent"),
    "'filename' must be the name of an existing file. "
  )

  testthat::expect_error(
    beastier::is_beast2_input_file(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "abs.ent"
    ),
    paste0(
      "'beast2_path' must be the full path of either 'beast' or 'launcher.jar'. ",
      "Both not found at path 'abs.ent'"
    )
  )

  expect_error(
    beastier::is_beast2_input_file(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "BEAST.exe"
    ),
    "Cannot use the Windows executable BEAST2.exe in scripts"
  )

})

test_that("detect warnings", {

  if (!is_beast2_installed()) return()

  testthat::expect_warning(
    is_beast2_input_file(
      filename = beastier:::get_beastier_path("beast2_warning.xml"),
      show_warnings = TRUE
    )
  )
  expect_silent(
    is_beast2_input_file(
      filename = beastier:::get_beastier_path("beast2_warning.xml"),
      show_warnings = FALSE
    )
  )
  if (rappdirs::app_dir()$os != "mac") {
    expect_silent(
      is_beast2_input_file(
        beautier:::get_beautier_paths("2_4.xml"),
        show_warnings = TRUE
      )
    )
  }
})
