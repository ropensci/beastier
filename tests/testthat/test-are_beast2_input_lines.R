context("are_beast2_input_lines")

test_that("use", {

  testthat::expect_true(
    lumier::are_beast2_input_lines(
      readLines(lumier::get_path("anthus_2_4.xml"))
    )
  )

  testthat::expect_true(
    lumier::are_beast2_input_lines(
      readLines(lumier::get_path("anthus_2_4.xml")),
      method = "deep"
    )
  )

  testthat::expect_true(
    lumier::are_beast2_input_lines(
      readLines(lumier::get_path("anthus_2_4.xml")),
      method = "fast"
    )
  )

})

test_that("abuse", {

  testthat::expect_error(
    lumier::are_beast2_input_lines(
      readLines(lumier::get_path("anthus_2_4.xml")),
      method = "nonsense"
    ),
    "'method' must be \"deep\" or \"fast\""
  )

})
