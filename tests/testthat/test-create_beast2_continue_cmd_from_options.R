test_that("minimal use", {
  if (!is_beast2_installed()) return()

  expect_silent(
    create_beast2_continue_cmd_from_options(
      beast2_options = create_beast2_options()
    )
  )
})

test_that("Run with spaces in the input filename, for Windows", {

  if (!is_beast2_installed()) return()

  cmd <- create_beast2_continue_cmd_from_options(
    create_beast2_options(
      input_filename = "file with spaces"
    )
  )
  expect_false("file with spaces" %in% cmd)
  expect_true(shQuote("file with spaces") %in% cmd)
})

test_that("Run with spaces in the ouput state filename, for Windows", {

  if (!is_beast2_installed()) return()

  cmd <- create_beast2_continue_cmd_from_options(
    create_beast2_options(
      input_filename = get_beastier_path("2_4.xml"),
      output_state_filename = "file with spaces"
    )
  )
  expect_false("file with spaces" %in% cmd)
  expect_true(shQuote("file with spaces") %in% cmd)
})
