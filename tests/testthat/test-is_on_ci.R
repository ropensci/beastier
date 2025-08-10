test_that("use", {
  expect_error(is_on_appveyor(), "Deprecated")
  expect_error(is_on_travis(), "Deprecated")
  expect_error(is_on_ci(), "Deprecated")
})
