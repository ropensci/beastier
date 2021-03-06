test_that("default locations", {

  if (rappdirs::app_dir()$os == "unix") {
    expect_true(
      grepl(
        "/home/[A-Za-z0-9_]*/.local/share/beast/bin/beast", # nolint use an absolute path here
        get_default_beast2_bin_path()
      )
    )
  }
  if (rappdirs::app_dir()$os == "win") {
    expect_true(
      grepl(
        "C:\\\\Users\\\\", # nolint use an absolute path here
        get_default_beast2_bin_path()
      )
    )
  }

})

test_that("must exist", {
  if (!is_beast2_installed()) return()
  expect_true(
    file.exists(get_default_beast2_bin_path())
  )
})

test_that("custom location", {

  if (rappdirs::app_dir()$os == "unix") {
    expect_equal(
      "something/beast/bin/beast", # nolint use an absolute path here
      get_default_beast2_bin_path(beast2_folder = "something")
    )
  }
})
