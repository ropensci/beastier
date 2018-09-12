context("is_bin_path")

test_that("use", {
  expect_true(beastier:::is_bin_path(get_default_beast2_bin_path()))
  expect_false(beastier:::is_bin_path(get_default_beast2_jar_path()))
  expect_false(beastier:::is_bin_path("nonsense"))
  expect_false(beastier:::is_bin_path(NA))
  expect_false(beastier:::is_bin_path(NULL))
})
