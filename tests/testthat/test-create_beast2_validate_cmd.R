context("create_beast2_validate_cmd")

test_that("use, bin", {

  if (!is_beast2_installed()) {
    return()
  }

  testit::assert(is_beast2_installed())

  beast2_bin_path <- get_default_beast2_bin_path()
  input_filename <- "input.xml"

  created <- create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_bin_path
  )
  expected <- c(
    beast2_bin_path,
    "-validate",
    input_filename
  )
  expect_equal(created, expected)
})

test_that("use, jar", {

  if (!is_beast2_installed()) {
    return()
  }

  testit::assert(is_beast2_installed())

  beast2_jar_path <- get_default_beast2_jar_path()
  input_filename <- "input.xml"

  created <- create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_jar_path
  )
  expected <- c(
    get_default_java_path(),
    "-cp",
    paste0("\"", beast2_jar_path, "\""),
    get_beast2_main_class_name(),
    "-validate",
    paste0("\"", input_filename, "\"")
  )
  expect_equal(created, expected)
})
