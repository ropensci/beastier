test_that("beast2_example_output.log is not a valid BEAST2 input file", {

  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("beast2_example_output.log")
  is_ok <- NULL

  expect_message(
    is_ok <- beastier::is_beast2_input_file(
      filename,
      verbose = TRUE
    )
  )

  expect_false(is_ok)
})

test_that("beast2_example_output.trees is not a valid BEAST2 input file", {

  # Gives a status error
  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("beast2_example_output.trees")

  is_ok <- NULL
  expect_message(
    is_ok <- beastier::is_beast2_input_file(filename, verbose = TRUE)
  )
  expect_false(is_ok)

})

test_that("anthus_2_4.xml is valid, from bin", {

  if (!is_on_ci()) return()

  # The .exe will always show a pop-up
  if (rappdirs::app_dir()$os == "win") return()

  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("anthus_2_4.xml")
  testit::assert(file.exists(filename))
  expect_true(
    beastier::is_beast2_input_file(
      filename,
      beast2_path = get_default_beast2_bin_path()
    )
  )
})

test_that("anthus_2_4.xml is valid, from jar", {

  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  filename <- get_beastier_path("anthus_2_4.xml")
  expect_true(file.exists(filename))
  expect_true(
    beastier::is_beast2_input_file(
      filename,
      beast2_path = get_default_beast2_jar_path()
    )
  )
})

test_that("abuse", {

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

})

test_that("detect warnings", {

  if (!is_beast2_installed()) return()

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
})

test_that("detect errors", {

  if (!is_beast2_installed()) return()

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
})

test_that("Check use of tilde in filenames", {

  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

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
})

test_that("show commands in output when verbose is TRUE", {
  if (!is_on_ci()) return()
  if (!is_beast2_installed()) return()

  beast2_folder <- tempfile(pattern = "beastier_")
  beastier::install_beast2(folder_name = beast2_folder)

  expect_message(
    beastier::is_beast2_input_file(
      filename = get_beastier_path("anthus_2_4.xml"),
      beast2_path = get_default_beast2_bin_path(beast2_folder = beast2_folder),
      verbose = TRUE
    ),
    beast2_folder
  )
})

test_that("Run with spaces in the input filename, for Windows", {

  if (!is_beast2_installed()) return()

  filename <- file.path(tempfile(), "path with spaces", "anthus_2_4.xml")
  dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)
  expect_true(is_beast2_input_file(get_beastier_path("anthus_2_4.xml")))
  file.copy(
    from = get_beastier_path("anthus_2_4.xml"),
    to = filename
  )
  expect_true(is_beast2_input_file(filename))
})



test_that("Run with spaces in the launcher.jar path, for Windows", {

  if (!is_beast2_installed()) return()

  beast2_folder <- file.path(tempfile(), "path with spaces", "even more")
  expect_silent(install_beast2(folder_name = beast2_folder))
  expect_true(is_beast2_installed(folder_name = beast2_folder))
  beast2_path <- get_default_beast2_bin_path(beast2_folder = beast2_folder)
  expect_true(
    is_beast2_input_file(
      filename = get_beastier_path("anthus_2_4.xml"),
      beast2_path = beast2_path
    )
  )
})

test_that("Run with spaces in the beast bin path, for Windows", {

  if (!is_beast2_installed()) return()

  skip("Need to install BEAST2 to folder with spaces instead")
  beast2_path <- file.path(
    tempfile(),
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
  expect_true(
    is_beast2_input_file(
      filename,
      beast2_path = beast2_path
    )
  )
})
