context("get_default_beast2_folder")

test_that("use", {

  if (rappdirs::app_dir()$os == "unix") {
    expect_true(
      grepl(
        "/home/[A-Za-z0-9_]*/.local/share",
        get_default_beast2_folder()
      )
    )
  }
  if (rappdirs::app_dir()$os == "win") {
    expect_true(
      grepl(
        "C:\\\\Users\\\\",
        get_default_beast2_folder()
      )
    )
  }
})
