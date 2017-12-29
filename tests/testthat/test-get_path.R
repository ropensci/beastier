context("get_path")

test_that("use", {

  testthat::expect_silent(
    lumier::get_path("anthus_2_4.xml")
  )

})

test_that("abuse", {

  testthat::expect_error(
    lumier::get_path("abs.ent"),
    "'filename' must be the name of a file in 'inst/extdata'"
  )

})
