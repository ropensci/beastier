context("get_default_beast2_jar_path")

test_that("must have a correct location", {

  if (rappdirs::app_dir()$os == "unix") {
    testthat::expect_true(
      grepl(
        "/home/[A-Za-z0-9_]*/.local/share/beast/lib/beast.jar", # nolint use an absolute path here
        get_default_beast2_jar_path()
      )
    )
  }
  if (rappdirs::app_dir()$os == "win") {
    testthat::expect_true(
      grepl(
        "C:\\\\Users\\\\", # nolint use an absolute path here
        get_default_beast2_jar_path()
      )
    )
  }
})

test_that("must exist", {

  if (is_beast2_installed()) {
    expect_true(
      file.exists(get_default_beast2_jar_path())
    )
  }
})
