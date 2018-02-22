context("create_beast2_run_cmd")

test_that("use", {

  beast2_jar_path <- "some/path/to/beast.jar"
  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  created <- create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite_state_file = TRUE,
    beast2_jar_path = beast2_jar_path
  )
  expected <- paste(
    "java -jar", beast2_jar_path,
    "-statefile", output_state_filename,
    "-overwrite",
    input_filename
  )
  testthat::expect_equal(created, expected)

})


test_that("use, WIRITTES", {

  input_filename <- "input.xml"
  output_state_filename <- "output.xml.state"
  rng_seed <- 42
  beast2_jar_path <- "C:/some/path/to/beast.jar"

  created <- create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = 8,
    use_beagle = TRUE,
    overwrite_state_file = TRUE,
    beast2_jar_path = beast2_jar_path
  )

  expected <- paste0(
    "java -jar ", beast2_jar_path,
    " -seed ", rng_seed,
    " -threads 8 -beagle",
    " -statefile ", output_state_filename,
    " -overwrite ",
    input_filename
  )

  testthat::expect_equal(created, expected)
})
