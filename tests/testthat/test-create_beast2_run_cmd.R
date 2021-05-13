test_that("minimal use", {
  if (!is_beast2_installed()) return()

  expect_silent(
    create_beast2_run_cmd(
      input_filename = tempfile(),
      output_state_filename = tempfile()
    )
  )
})

test_that("same results as create_beast2_run_cmd_from_options", {
  if (!is_beast2_installed()) return()

  input_filename <- tempfile()
  output_state_filename <- tempfile()
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
