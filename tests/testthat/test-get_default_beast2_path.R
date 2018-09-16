context("get_default_beast2_path")

test_that("must be either binary or jar file", {

  testit::assert(is_beast2_installed())

  def_path <- get_default_beast2_path()
  bin_path <- get_default_beast2_bin_path()
  jar_path <- get_default_beast2_jar_path()
  expect_true(def_path == bin_path || def_path == jar_path)
})

test_that("must exist", {

  testit::assert(is_beast2_installed())

  expect_true(
    file.exists(get_default_beast2_path())
  )
})
