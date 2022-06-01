test_that("minimal use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  expect_silent(
    create_beast2_run_cmd(
      input_filename = "irrelevant",
      output_state_filename = "irrelevant_too"
    )
  )
  check_empty_beaustier_folders()
})

test_that("use of 'stack_size_kb'", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  # This is existing behavior
  cmd <- create_beast2_run_cmd(
    input_filename = get_beastier_path("2_4.xml"), # actual file is irrelevant
    output_state_filename = "something"
  )
  expect_equal(0, length(stringr::str_subset(string = cmd, pattern = "-Xss")))
  check_empty_beaustier_folders()

  skip("Issue 60")
  check_empty_beaustier_folders()

  cmd <- create_beast2_run_cmd(
    input_filename = get_beastier_path("2_4.xml"), # actual file is irrelevant
    output_state_filename = "something",
    stack_size_kb = 2000
  )
 expect_equal(1, length(stringr::str_subset(string = cmd, pattern = "-Xss")))
 expect_true("-Xss2000k" %in% cmd)


  cmd <- create_beast2_run_cmd(
    input_filename = "something",
    output_state_filename = "something",
    stack_size_kb = 1234
  )
  expect_equal(1, length(stringr::str_subset(string = cmd, pattern = "-Xss")))
  expect_true("-Xss1234k" %in% cmd)
  expect_equal(cmd_from_args, cmd_from_options)

  check_empty_beaustier_folders()
})

test_that("same results as create_beast2_run_cmd_from_options", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

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
  check_empty_beaustier_folders()
})
