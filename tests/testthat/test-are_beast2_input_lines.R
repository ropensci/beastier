context("are_beast2_input_lines")

test_that("use, fast", {

  if (!is_beast2_installed()) return()

  expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml"))
    )
  )

  expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml")),
      method = "fast"
    )
  )

})

test_that("use, deep", {

  if (!is_beast2_installed()) return()

  expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml")),
      method = "deep",
      verbose = TRUE,
      beast2_path = get_default_beast2_jar_path()
    )
  )

  expect_true(
    beastier::are_beast2_input_lines(
      readLines(beastier::get_beastier_path("anthus_2_4.xml")),
      method = "deep",
      verbose = TRUE,
      beast2_path = get_default_beast2_bin_path()
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
