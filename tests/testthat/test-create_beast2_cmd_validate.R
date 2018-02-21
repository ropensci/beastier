context("create_beast2_cmd_validate")

test_that("use", {

  beast_jar_path <- "beast.jar"
  input_filename <- "input.xml"

  created <- beastier:::create_beast2_cmd_validate(
    input_filename = input_filename,
    beast_jar_path = beast_jar_path
  )
  expected <- paste(
    "java -jar", beast_jar_path,
    "-validate", input_filename
  )
  testthat::expect_equal(created, expected)

})
