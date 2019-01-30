context("test-check_rng_seed")

test_that("use", {
  expect_silent(check_rng_seed(1))
  expect_silent(check_rng_seed(NA))

  expect_error(
    check_rng_seed(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)),
    "'rng_seed' should be one value"
  )

  expect_error(
    check_rng_seed(0),
    "'rng_seed' should be one NA or one non-zero positive value"
  )
  expect_error(check_rng_seed("nonsense"))
  expect_error(check_rng_seed(NULL))
})
