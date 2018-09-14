context("get_default_beast2_bin_path")

test_that("use", {

  if (rappdirs::app_dir()$os == "unix") {
    testthat::expect_true(
      grepl(
        "/home/[A-Za-z0-9_]*/.local/share/beast/bin/beast",
        get_default_beast2_bin_path()
      )
    )
  }
  if (rappdirs::app_dir()$os == "win") {
    testthat::expect_true(
      grepl(
        "C:\\\\Users\\\\",
        get_default_beast2_bin_path()
      )
    )
  }

})

test_that("must exist", {

  if (is_beast2_installed()) {
    expect_true(
      file.exists(get_default_beast2_bin_path())
    )
  }
})
