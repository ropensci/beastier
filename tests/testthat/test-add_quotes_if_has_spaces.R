test_that("use", {
  remove_beaustier_folders()

  expect_equal(add_quotes_if_has_spaces("x"), "x")
  expect_equal(add_quotes_if_has_spaces("a b"), shQuote("a b"))
})

test_that("abuse", {
  expect_error(
    add_quotes_if_has_spaces(NULL),
    "'filename' must be a string"
  )
  expect_error(
    add_quotes_if_has_spaces(NA),
    "'filename' must be a string"
  )
  expect_error(
    add_quotes_if_has_spaces(3),
    "'filename' must be a string"
  )
  expect_error(
    add_quotes_if_has_spaces(Inf),
    "'filename' must be a string"
  )
  expect_error(
    add_quotes_if_has_spaces(c("a", "b")),
    "'filename' must be one string"
  )
})
