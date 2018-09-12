context("create_beast2_validate_cmd")

test_that("use", {

  beast2_jar_path <- file.path("some_path", "beast.jar")
  input_filename <- "input.xml"

  created <- beastier:::create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_jar_path
  )
  expected <- c(
    "java", "-jar",
    paste0("\"", beast2_jar_path, "\""),
    "-validate",
    paste0("\"", input_filename, "\"")
  )
  testthat::expect_equal(created, expected)
})
