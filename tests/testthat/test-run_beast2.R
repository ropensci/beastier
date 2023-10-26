test_that("single alignment creates all files", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  output_state_filename <- get_beastier_tempfilename(fileext = ".xml.state")

  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_state_filename = output_state_filename
  )

  expect_true(file.exists(output_state_filename))
  file.remove(output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("single alignment, equal RNG seed equal results", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  if (rappdirs::app_dir()$os == "mac") {
    skip("On MacOS these results do differ, no idea why")
  }

  check_empty_beaustier_folders()

  output_state_filename_1 <- get_beastier_tempfilename(fileext = "_1.xml.state")
  output_state_filename_2 <- get_beastier_tempfilename(fileext = "_2.xml.state")
  dir.create(
    dirname(output_state_filename_1), showWarnings = FALSE, recursive = TRUE
  )
  dir.create(
    dirname(output_state_filename_2), showWarnings = FALSE, recursive = TRUE
  )
  output_files <- c(
    output_state_filename_1,
    output_state_filename_2
  )
  expect_true(!all(file.exists(output_files)))

  rng_seed <- 42
  stdout_1 <- run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_state_filename = output_state_filename_1,
    rng_seed = rng_seed
  )
  stdout_2 <- run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_state_filename = output_state_filename_2,
    rng_seed = rng_seed
  )
  expect_equal(length(stdout_1), length(stdout_2))
  expect_equal(2, sum(stdout_1 != stdout_2))
  expect_true(
    all(
      !beautier::is_one_na(
        stringr::str_match(
          string = stdout_1[stdout_1 != stdout_2][1],
          pattern = "^Writing state to file"
        )
      )
    )
  )
  expect_true(
    all(
      !beautier::is_one_na(
        stringr::str_match(
          string = stdout_1[stdout_1 != stdout_2][2],
          pattern = "^Total calculation time:"
        )
      )
    )
  )
  lines_1 <- readLines(output_state_filename_1)
  lines_2 <- readLines(output_state_filename_2)
  expect_identical(lines_1, lines_2)
  file.remove(output_state_filename_1)
  file.remove(output_state_filename_2)
  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("detect errors when BEAST2 is installed", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  expect_error(
    run_beast2(get_beastier_path("anthus_aco.fas")),
    "'input_filename' must be a valid BEAST2 XML file"
  )

  check_empty_beaustier_folders()
})

test_that("BEAST2 does not overwrite the .xml.state file specified by user", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  output_state_filename <- get_beastier_tempfilename(fileext = ".xml.state")

  # Create files to be detectably overwritten
  dir.create(
    dirname(output_state_filename), recursive = TRUE, showWarnings = FALSE
  )
  write(x = "state", file = output_state_filename)
  expect_true(all(readLines(output_state_filename, warn = FALSE) == "state"))

  # Delete the log file iff it is present,
  # only needed when running these tests locally for multiple times
  input_filename <- get_beastier_path("2_4.xml")

  expect_error(
    run_beast2(
      input_filename = input_filename,
      output_state_filename = output_state_filename,
      overwrite = FALSE
    ),
    "Will not overwrite 'output_state_filename'"
  )
  file.remove(output_state_filename)
  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("BEAST2 overwrites state file", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  input_filename <- get_beastier_path("2_4.xml")
  output_state_filename <- get_beastier_tempfilename(fileext = ".state")

  # Create files to be detectably overwritten
  dir.create(
    dirname(output_state_filename), recursive = TRUE, showWarnings = FALSE
  )
  write(x = "state", file = output_state_filename)

  expect_true(all(readLines(output_state_filename) == "state"))

  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2(
    input_filename = input_filename,
    output_state_filename = output_state_filename
  )

  # Overwrites all
  expect_true(all(readLines(output_state_filename) != "state"))
  file.remove(output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("run BEAST2 from jar path", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  output_state_filename <- get_beastier_tempfilename()

  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    beast2_path = get_default_beast2_jar_path(),
    output_state_filename = output_state_filename
  )
  file.remove(output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("run BEAST2 from binary path", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  # Binary fails under Windows, but works under Unix (see 'use' section above)
  if (rappdirs::app_dir()$os == "unix") {
    output_state_filename <- get_beastier_tempfilename()
    # Cannot use 'expect_silent' as an empty line is produced in the output
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      beast2_path = get_default_beast2_bin_path(),
      output_state_filename = output_state_filename
    )
    file.remove(output_state_filename)
    remove_beaustier_folders()
    check_empty_beaustier_folders()
  }
  # Binary fails under Windows, but works under Unix (see 'use' section above)
  if (rappdirs::app_dir()$os == "win") {
    fake_windows_exe_filename <- file.path(
      get_beastier_tempfilename(),
      "BEAST2.exe"
    )
    expect_true(is_bin_path(fake_windows_exe_filename))
    dir.create(
      dirname(fake_windows_exe_filename),
      recursive = TRUE, showWarnings = FALSE
    )
    writeLines(text = "dummy content", con = fake_windows_exe_filename)
    expect_error(
      run_beast2(
        input_filename = get_beastier_path("beast2_warning.xml"),
        beast2_path = fake_windows_exe_filename
      ),
      "'CreateProcess' failed to run"
    )
    remove_beaustier_folders()
    check_empty_beaustier_folders()
  }

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("run_beast2 produces output", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  remove_beaustier_folders()

  output_state_filename <- get_beastier_tempfilename()

  # From https://stackoverflow.com/a/2501913
  if (rappdirs::app_dir()$os == "win") {
    sink("NUL")
  } else {
    sink("/dev/null")
  }
  output <- run_beast2(
    get_beastier_path("2_4.xml"),
    output_state_filename = output_state_filename,
    verbose = TRUE
  )
  sink()
  expect_true(length(output) > 50)

  file.remove(output_state_filename)
  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
