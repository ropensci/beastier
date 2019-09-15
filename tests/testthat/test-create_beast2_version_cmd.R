context("create_beast2_version_cmd")

test_that("use, bin", {

  if (!is_beast2_installed()) {
    return()
  }

  testit::assert(is_beast2_installed())

  beast2_bin_path <- get_default_beast2_bin_path()
  input_filename <- "input.xml"

  created <- create_beast2_version_cmd(
    beast2_path = beast2_bin_path
  )
  expected <- c(
    beast2_bin_path,
    "-version"
  )
  expect_equal(created, expected)
})

test_that("use, jar", {

  if (!is_beast2_installed()) {
    return()
  }

  testit::assert(is_beast2_installed())

  beast2_jar_path <- get_default_beast2_jar_path()

  created <- create_beast2_version_cmd(
    beast2_path = beast2_jar_path
  )
  expected <- c(
    get_default_java_path(),
    "-jar",
    paste0("\"", beast2_jar_path, "\""),
    "-version"
  )
  expect_equal(created, expected)
})