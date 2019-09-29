context("are_beast2_input_lines")

test_that("use, fast", {

  if (!is_beast2_installed()) return()

  expect_true(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml"))
    )
  )

  expect_true(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml")),
      method = "fast"
    )
  )

})

test_that("use, deep", {

  if (!is_beast2_installed()) return()

  expect_true(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml")),
      method = "deep",
      beast2_path = get_default_beast2_path()
    )
  )
})

test_that("abuse", {

  expect_error(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml")),
      method = "nonsense"
    ),
    "'method' must be \"deep\" or \"fast\""
  )
})
