context("is_jar_path")

test_that("use", {
  expect_true(beastier:::is_jar_path(get_default_beast2_jar_path()))
  expect_false(beastier:::is_jar_path(get_default_beast2_bin_path()))
  expect_false(beastier:::is_jar_path("nonsense"))
  expect_false(beastier:::is_jar_path(NA))
  expect_false(beastier:::is_jar_path(NULL))
})
