context("get_path")

test_that("use", {

  testthat::expect_silent(
    beastier::get_path("anthus_2_4.xml")
  )

})

test_that("abuse", {

  testthat::expect_error(
    beastier::get_path("abs.ent"),
    "'filename' must be the name of a file in 'inst/extdata'"
  )

})
