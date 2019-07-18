context("get_beastier_path")

test_that("use", {

  expect_silent(
    beastier::get_beastier_path("anthus_2_4.xml")
  )

})

test_that("abuse", {

  expect_error(
    beastier::get_beastier_path("abs.ent"),
    "'filename' must be the name of a file in 'inst/extdata'"
  )

})
