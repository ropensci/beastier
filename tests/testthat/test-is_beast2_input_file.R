context("is_beast2_input_file")

test_that("beast2_example_output.log is not a valid BEAST2 input file", {

  if (!lumier:::is_on_travis()) return()

  filename <- get_path("beast2_example_output.log")
  is_ok <- NULL

  testthat::expect_output(
    is_ok <- lumier::is_beast2_input_file(filename, verbose = TRUE)
  )

  testthat::expect_false(is_ok)

})

test_that("beast2_example_output.trees is not a valid BEAST2 input file", {

  # Gives a status error
  if (!lumier:::is_on_travis()) return()

  filename <- get_path("beast2_example_output.trees")

  is_ok <- NULL

  testthat::expect_output(
    is_ok <- lumier::is_beast2_input_file(filename, verbose = TRUE)
  )

  testthat::expect_false(is_ok)

})

test_that("anthus_2_4.xml is valid", {

  if (!lumier:::is_on_travis()) return()

  filename <- get_path("anthus_2_4.xml")
  testthat::expect_true(file.exists(filename))
  testthat::expect_true(lumier::is_beast2_input_file(filename))

})

test_that("abuse", {

  testthat::expect_error(
    lumier::is_beast2_input_file("abs.ent"),
    "'filename' must be the name of an existing file. "
  )

  testthat::expect_error(
    lumier::is_beast2_input_file(
      get_path("anthus_2_4.xml"),
      beast_jar_path = "abs.ent"
    ),
    "'beast_jar_path' must be the fullpath of the BEAST2 file 'beast2.jar'."
  )

})
