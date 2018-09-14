context("get_default_java_path")

test_that("must be non-null", {
  expect_true(!is.null(get_default_java_path()))
})

test_that("must exist", {
  expect_true(
    file.exists(get_default_java_path())
  )
})
