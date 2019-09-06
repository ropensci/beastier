test_that("use", {
  if (!is_beast2_installed()) return()

  expect_silent(upgrade_beast2())
})
