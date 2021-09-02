test_that("minimal use", {
  if (!is_beast2_installed()) return()

  expect_silent(
    create_beast2_run_cmd(
      input_filename = "irrelevant",
      output_state_filename = "irrelevant_too"
    )
  )
})

test_that("minimal use", {
  skip("Issue 60")
  cmd <- create_beast2_run_cmd(
    input_filename = "something",
    output_state_filename = "something"
  )
  expect_equal(0, stringr::str_count(string = cmd, pattern = "-Xss"))


 cmd <- create_beast2_run_cmd(
    input_filename = "something",
    output_state_filename = "something",
    stack_size_kb = 2000
  )
  expect_equal(1, stringr::str_count(string = cmd, pattern = "-Xss"))
  expect_true("-Xss2000k" %in% cmd)


 cmd <- create_beast2_run_cmd(
    input_filename = "something",
    output_state_filename = "something",
    stack_size_kb = 1234
  )
  expect_equal(1, stringr::str_count(string = cmd, pattern = "-Xss"))
  expect_true("-Xss1234k" %in% cmd)

})

test_that("same results as create_beast2_run_cmd_from_options", {
  if (!is_beast2_installed()) return()

  input_filename <- "irrelevant"
  output_state_filename <- "irrelevant_too"
  overwrite <- TRUE

  cmd_from_args <- create_beast2_run_cmd(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    overwrite = overwrite
  )

  cmd_from_options <- create_beast2_run_cmd_from_options(
    create_beast2_options(
      input_filename = input_filename,
      output_state_filename = output_state_filename,
      overwrite = overwrite
    )
  )
  expect_equal(cmd_from_args, cmd_from_options)
})
