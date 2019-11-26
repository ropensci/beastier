context("install_beast2")

test_that("install at non-standard location", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()


  folder_name <- tempdir()
  beast_jar_path <- file.path(folder_name, "beast", "lib", "launcher.jar")
  testit::assert(!file.exists(beast_jar_path))
  expect_output(
    install_beast2(folder_name, verbose = TRUE),
    "BEAST2 installed at"
  )
  expect_true(file.exists(beast_jar_path))
  expect_true(is_beast2_installed(folder_name = folder_name))
})

test_that("install twice must throw", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()

  folder_name <- tempdir()
  if (!is_beast2_installed(folder_name)) {
    install_beast2(folder_name)
  }
  expect_error(
    install_beast2(folder_name),
    "BEAST2 already installed"
  )
})
