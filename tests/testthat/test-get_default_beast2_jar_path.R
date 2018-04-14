context("get_default_beast2_jar_path")

test_that("use", {

  if (rappdirs::app_dir()$os == "unix") {
    testthat::expect_true(
      grepl(
        "/home/[A-Za-z0-9_]*/.local/share/beast/lib/beast.jar",
        get_default_beast2_jar_path()
      )
    )
  }
  if (rappdirs::app_dir()$os == "win") {
    testthat::expect_true(
      grepl(
        "C:/Users/<username>/Local/beast/beast/lib/beast.jar",
        get_default_beast2_jar_path()
      )
    )
  }

})
