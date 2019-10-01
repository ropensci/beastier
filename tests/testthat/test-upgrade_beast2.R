test_that("use", {
  if (!is_beast2_installed()) return()

  expect_silent(upgrade_beast2())
})


test_that("give error when BEAST2 is not installed", {
  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  testit::assert(is_beast2_installed())

  beastier::uninstall_beast2()
  expect_error(upgrade_beast2(), "BEAST2 is not installed")
  beastier::install_beast2()

  testit::assert(is_beast2_installed())
})

