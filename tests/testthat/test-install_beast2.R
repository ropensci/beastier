context("install_beast2")

test_that("use", {

  folder_name <- tempdir()
  beast_jar_path <- paste0(folder_name, "/beast/lib/beast.jar")
  testit::assert(!file.exists(beast_jar_path))
  install_beast2(folder_name)
  testthat::expect_true(file.exists(beast_jar_path))
})
