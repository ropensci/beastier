context("is_beast2_installed")

test_that("use", {

  if (is_beast2_installed()) {
    uninstall_beast2()
    expect_false(is_beast2_installed())
    install_beast2()
    expect_true(is_beast2_installed())
  } else  {
    testit::assert(!is_beast2_installed())
    install_beast2()
    expect_true(is_beast2_installed())
    uninstall_beast2()
    expect_false(is_beast2_installed())
  }
})
