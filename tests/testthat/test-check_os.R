context("check_os")

test_that("use", {
  expect_silent(check_os("mac"))
  expect_silent(check_os("unix"))
  expect_silent(check_os("win"))
  expect_error(
    check_os("nonsense"),
    "'os' must be either 'mac', 'unix' or 'win'"
  )
})
