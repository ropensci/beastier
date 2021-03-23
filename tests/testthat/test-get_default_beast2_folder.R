test_that("use", {

  if (rappdirs::app_dir()$os == "unix") {
    expect_true(
      grepl(
        ".local/share", # nolint use an absolute path here
        get_default_beast2_folder()
      )
    )
  }
  if (rappdirs::app_dir()$os == "win") {
    expect_true(
      grepl(
        "C:\\\\Users\\\\", # nolint use an absolute path here
        get_default_beast2_folder()
      )
    )
  }
})
