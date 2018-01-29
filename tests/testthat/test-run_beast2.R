context("run_beast2")

test_that("use", {

  skip("WIP")
  testthat::expect_silent(
    run_beast2(get_path("anthus_2_4.xml"))
  )

  run_beast2(get_path("2_4.xml"), verbose = TRUE)

})

test_that("abuse", {

  testthat::expect_error(
    run_beast2("abs.ent"),
    "'input_filename' must be the name of an existing file"
  )

  testthat::expect_error(
    run_beast2(get_path("anthus_aco.fas")),
    "'input_filename' must be a valid BEAST2 XML file"
  )

  testthat::expect_error(
    run_beast2(
      get_path("anthus_2_4.xml"),
      beast_jar_path = "abs.ent"
    ),
    "'beast_jar_path' must be the name of an existing file"
  )

})
