context("create_beast2_run_cmd")

test_that("use, bin", {

  if (!is_beast2_installed()) return()

  testit::assert(is_beast2_installed())
  beast2_bin_path <- get_default_beast2_bin_path()
  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  created <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite = TRUE,
    beast2_path = beast2_bin_path
  )
  expected <- c(
    beast2_bin_path,
    "-statefile",
    paste0("\"", output_state_filename, "\""),
    "-overwrite",
    paste0("\"", input_filename, "\"")
  )
  expect_equal(created, expected)
})

test_that("use, jar", {

  if (!is_beast2_installed()) return()

  testit::assert(is_beast2_installed())
  beast2_jar_path <- get_default_beast2_jar_path()
  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  created <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite = TRUE,
    beast2_path = beast2_jar_path
  )

  beast2_jar_path <- shQuote(beast2_jar_path)

  expected <- c(
    get_default_java_path(),
    "-cp",
    beast2_jar_path,
    get_beast2_main_class_name(),
    "-statefile",
    paste0("\"", output_state_filename, "\""),
    "-overwrite",
    paste0("\"", input_filename, "\"")
  )
  expect_equal(created, expected)
})

test_that("different overwrite option results in different command", {

  if (!is_beast2_installed()) return()

  testit::assert(is_beast2_installed())

  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  cmd_true <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite = TRUE
  )
  cmd_false <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite = FALSE
  )
  expect_true(length(cmd_false) != length(cmd_true))

})

test_that("different use_beagle option results in different command", {

  if (!is_beast2_installed()) return()

  testit::assert(is_beast2_installed())

  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  cmd_true <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    use_beagle = TRUE
  )
  cmd_false <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    use_beagle = FALSE
  )
  expect_true(length(cmd_false) != length(cmd_true))

})

test_that("different n_threads option results in different command", {

  if (!is_beast2_installed()) return()

  testit::assert(is_beast2_installed())

  output_state_filename <- "output.xml.state"
  input_filename <- "input.xml"

  cmd_true <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    n_threads = 2
  )
  cmd_false <- beastier::create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    n_threads = 3
  )
  expect_false(all(cmd_false == cmd_true))
})
