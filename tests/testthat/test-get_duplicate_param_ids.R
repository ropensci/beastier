context("get_duplicate_param_ids")

test_that("use", {

  text_0 <- "<parameter id=\"RealParameter.1\" ...</parameter>"
  text_1 <- c(text_0, text_0)

  expect_equal(
    length(get_duplicate_param_ids(text_0)),
    0
  )

  expect_equal(
    length(get_duplicate_param_ids(text_1)),
    1
  )

})

test_that("abuse", {

  expect_error(
    get_duplicate_param_ids(NA),
    "'text' must be text"
  )

  expect_error(
    get_duplicate_param_ids(NULL),
    "'text' must be text"
  )

  expect_error(
    get_duplicate_param_ids(ape::rcoal(3)),
    "'text' must be text"
  )

})
