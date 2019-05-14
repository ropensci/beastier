context("test-do_minimal_run")

test_that("use", {
  if (!is_beast2_installed()) {
    install_beast2()
  }
  testit::assert(is_beast2_installed())
  expect_silent(do_minimal_run())
})
