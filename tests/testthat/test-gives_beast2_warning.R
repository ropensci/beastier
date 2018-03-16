context("gives_beast2_warning")

test_that("use", {

  testthat::expect_true(
    gives_beast2_warning(
      filename = beastier:::get_beastier_path("beast2_warning.xml")
    )
  )
  testthat::expect_output(
    gives_beast2_warning(
      filename = beastier:::get_beastier_path("beast2_warning.xml"),
      verbose = TRUE
    )
  )
  testthat::expect_false(
    gives_beast2_warning(
      beautier:::get_beautier_paths("2_4.xml")
    )
  )
})

test_that("abuse", {

  testthat::expect_error(
    gives_beast2_warning("abs.ent"),
    "'filename' must be the name of an existing file. "
  )

  testthat::expect_error(
    gives_beast2_warning(
      get_beastier_path("anthus_2_4.xml"),
      beast2_jar_path = "abs.ent"
    ),
    "'beast2_jar_path' must be the full path of the BEAST2 file 'beast.jar'."
  )

})
