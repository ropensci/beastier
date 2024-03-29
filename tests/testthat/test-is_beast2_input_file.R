test_that("beast2_example_output.log is not a valid BEAST2 input file", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  filename <- get_beastier_path("beast2_example_output.log")
  is_ok <- NULL

  expect_message(
    is_ok <- beastier::is_beast2_input_file(
      filename,
      verbose = TRUE
    )
  )

  expect_false(is_ok)
  check_empty_beaustier_folders()
})

test_that("beast2_example_output.trees is not a valid BEAST2 input file", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  filename <- get_beastier_path("beast2_example_output.trees")

  is_ok <- NULL
  expect_message(
    is_ok <- beastier::is_beast2_input_file(filename, verbose = TRUE)
  )
  expect_false(is_ok)

  check_empty_beaustier_folders()
})

test_that("anthus_2_4.xml is valid, from bin", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  # The .exe will always show a pop-up
  skip_on_os(os = "windows")

  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  filename <- get_beastier_path("anthus_2_4.xml")
  expect_true(file.exists(filename))
  expect_true(
    beastier::is_beast2_input_file(
      filename,
      beast2_path = get_default_beast2_bin_path()
    )
  )
  check_empty_beaustier_folders()
})

test_that("anthus_2_4.xml is valid, from jar", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  filename <- get_beastier_path("anthus_2_4.xml")
  expect_true(file.exists(filename))
  expect_true(
    beastier::is_beast2_input_file(
      filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )

  check_empty_beaustier_folders()
})

test_that("abuse", {
  check_empty_beaustier_folders()

  expect_error(
    is_beast2_input_file("abs.ent"),
    "File 'filename' not found. Could not find file with path 'abs.ent'"
  )

  expect_error(
    beastier::is_beast2_input_file(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "abs.ent"
    ),
    paste0(
      "'beast2_path' must be the full path of either 'beast' or 'launcher.jar'. ", # nolint indeed a long line
      "Both not found at path 'abs.ent'"
    )
  )

  expect_error(
    beastier::is_beast2_input_file(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "BEAST.exe"
    ),
    "Cannot use the Windows executable BEAST2.exe in scripts"
  )
  check_empty_beaustier_folders()
})

test_that("detect warnings", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  expect_warning(
    is_beast2_input_file(
      filename = get_beastier_path("beast2_warning.xml"),
      show_warnings = TRUE
    )
  )
  expect_silent(
    is_beast2_input_file(
      filename = get_beastier_path("beast2_warning.xml"),
      show_warnings = FALSE
    )
  )
  if (rappdirs::app_dir()$os != "mac") {
    expect_silent(
      is_beast2_input_file(
        beautier:::get_beautier_paths("2_4.xml"),
        show_warnings = TRUE
      )
    )
  }
  check_empty_beaustier_folders()
})

test_that("detect errors", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  if (1 == 2) {
    # I guess that BEAST v2.4 gave a warning for this XML file,
    # but a later version (such as v2.6.2) does correct for that
    # being warned for.
    expect_warning(
      is_beast2_input_file(
        filename = get_beastier_path("beast2_error.xml"),
        show_warnings = TRUE
      )
    )
  }
  expect_silent(
    is_beast2_input_file(
      filename = get_beastier_path("beast2_error.xml"),
      show_warnings = FALSE
    )
  )

  check_empty_beaustier_folders()
})

test_that("Check use of tilde in filenames", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  # Copy a file to the home folder, must be deleted in the end
  full_path <- get_beastier_path("2_4.xml")
  relative_path <- "~/2_4.xml"
  file.copy(from = full_path, to = relative_path)

  # Both files are identical
  expect_equivalent(readLines(full_path), readLines(relative_path))

  # The file with the full path must be valid
  expect_true(is_beast2_input_file(full_path))

  # The file with the relative path must be valid as well then
  expect_true(is_beast2_input_file(relative_path))

  file.remove(relative_path)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("Run with spaces in the input filename, for Windows", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  filename <- file.path(
    get_beastier_tempfilename(), "path with spaces", "anthus_2_4.xml"
  )
  dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)
  expect_true(is_beast2_input_file(get_beastier_path("anthus_2_4.xml")))
  file.copy(
    from = get_beastier_path("anthus_2_4.xml"),
    to = filename
  )
  expect_true(is_beast2_input_file(filename))
  unlink(dirname(dirname(filename)), recursive = TRUE)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
