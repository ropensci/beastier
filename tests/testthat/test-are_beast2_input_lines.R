context("are_beast2_input_lines")

test_that("use", {

  testthat::expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml"))
    )
  )


  testthat::expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml")),
      method = "deep",
      verbose = TRUE
    )
  )

  testthat::expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml")),
      method = "fast"
    )
  )

})

test_that("abuse", {

  testthat::expect_error(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml")),
      method = "nonsense"
    ),
    "'method' must be \"deep\" or \"fast\""
  )

})
