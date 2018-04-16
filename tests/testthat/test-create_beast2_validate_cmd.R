context("create_beast2_validate_cmd")

test_that("use", {

  beast2_jar_path <- file.path("some_path", "beast.jar")
  input_filename <- "input.xml"

  created <- beastier:::create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_jar_path = beast2_jar_path
  )
  expected <- paste0(
    "java -jar ",
    "\"", beast2_jar_path, "\"",
    " -validate ",
    "\"", input_filename, "\""
  )
  testthat::expect_equal(created, expected)

})
