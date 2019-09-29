test_that("use", {
  if (!is_beast2_installed()) return()

  expect_equal(get_beast2_version(), "2.6.1")
})
