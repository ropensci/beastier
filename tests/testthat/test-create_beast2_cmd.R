context("create_beast2_cmd")

test_that("use", {

  beast_jar_path <- "beast.jar"
  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  created <- beastier:::create_beast2_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite_state_file = TRUE,
    beast_jar_path = beast_jar_path
  )
  expected <- paste(
    "java -jar", beast_jar_path,
    "-statefile", output_state_filename,
    "-overwrite",
    input_filename
  )
  testthat::expect_equal(created, expected)

})
