context("test-check_n_threads")

test_that("use", {
  expect_silent(check_n_threads(1))
  expect_silent(check_n_threads(NA))

  expect_error(
    check_n_threads(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)),
    "'n_threads' should be one value"
  )

  expect_error(
    check_n_threads(0),
    "'n_threads' should be one NA or one non-zero positive value"
  )
  expect_error(check_n_threads("nonsense"))
  expect_error(check_n_threads(NULL))
})
