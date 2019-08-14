context("is_jar_path")

test_that("use", {
  expect_true(is_jar_path(get_default_beast2_jar_path()))
  expect_false(is_jar_path(get_default_beast2_bin_path()))
  expect_false(is_jar_path("nonsense"))
  expect_false(is_jar_path(""))
  expect_false(is_jar_path(NA))
  expect_false(is_jar_path(NULL))
  expect_false(is_jar_path(Inf))
})
