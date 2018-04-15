context("install_beast2")

test_that("use", {

  if (!is_on_travis()) return()

  folder_name <- tempdir()
  beast_jar_path <- file.path(folder_name, "beast", "lib", "beast.jar")
  testit::assert(!file.exists(beast_jar_path))
  install_beast2(folder_name)
  testthat::expect_true(file.exists(beast_jar_path))
})

test_that("default", {

  if (!is_on_travis()) return()

  beast_jar_path <- get_default_beast2_jar_path()
  if (!file.exists(beast_jar_path)) {
    install_beast2()
  }
  testthat::expect_true(file.exists(beast_jar_path))
})
