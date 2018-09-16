context("create_beast2_validate_cmd")

test_that("use, bin", {

  testit::assert(is_beast2_installed())

  beast2_bin_path <- get_default_beast2_bin_path()
  input_filename <- "input.xml"

  created <- beastier:::create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_bin_path
  )
  expected <- c(
    beast2_bin_path,
    "-validate",
    paste0("\"", input_filename, "\"")
  )
  testthat::expect_equal(created, expected)
})

test_that("use, jar", {

  testit::assert(is_beast2_installed())

  beast2_jar_path <- get_default_beast2_jar_path()
  input_filename <- "input.xml"

  created <- beastier:::create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_jar_path
  )
  expected <- c(
    get_default_java_path(),
    "-jar",
    paste0("\"", beast2_jar_path, "\""),
    "-validate",
    paste0("\"", input_filename, "\"")
  )
  testthat::expect_equal(created, expected)
})
