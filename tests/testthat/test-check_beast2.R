test_that("use", {

  if (!is_on_ci()) return()

  if (is_beast2_installed()) {
    expect_silent(check_beast2())
    uninstall_beast2()
    expect_error(check_beast2())
    install_beast2()
    expect_silent(check_beast2())
  } else {
    expect_error(check_beast2())
    install_beast2()
    expect_silent(check_beast2())
    uninstall_beast2()
    expect_error(check_beast2())
  }
})
