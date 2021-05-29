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

test_that("Run with spaces in the output state filename, for Windows", {

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

test_that("Run with spaces in the launcher.jar path, for Windows", {

  if (!is_beast2_installed()) return()

  beast2_path <- file.path(
    get_beastier_tempfilename(),
    "path with spaces",
    "launcher.jar"
  )
  expect_true(is_jar_path(beast2_path))
  dir.create(dirname(beast2_path), showWarnings = FALSE, recursive = TRUE)
  file.copy(
    from = get_default_beast2_path(),
    to = beast2_path
  )
  expect_true(file.exists(beast2_path))



  cmd <- create_beast2_continue_cmd_from_options(
    beast2_options = create_beast2_options(
      beast2_path = beast2_path
    )
  )
  expect_false(beast2_path %in% cmd)
  expect_true(shQuote(beast2_path) %in% cmd)
})

test_that("Run with spaces in the beast bin path, for Windows", {

  if (!is_beast2_installed()) return()

  beast2_path <- file.path(
    get_beastier_tempfilename(),
    "path with spaces",
    "beast"
  )
  expect_true(is_bin_path(beast2_path))
  dir.create(dirname(beast2_path), showWarnings = FALSE, recursive = TRUE)
  file.copy(
    from = get_default_beast2_bin_path(),
    to = beast2_path
  )
  expect_true(file.exists(beast2_path))



  cmd <- create_beast2_continue_cmd_from_options(
    beast2_options = create_beast2_options(
      beast2_path = beast2_path
    )
  )
  expect_false(beast2_path %in% cmd)
  expect_true(shQuote(beast2_path) %in% cmd)
})
