test_that("single alignment creates all files", {
  if (!is_beast2_installed()) return()
  output_state_filename <- get_beastier_tempfilename(fileext = ".xml.state")
  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_state_filename = output_state_filename
    )
  )
  expect_true(file.exists(output_state_filename))
  file.remove(output_state_filename)
})

test_that("single alignment, equal RNG seed equal results", {

  if (!is_beast2_installed()) return()

  if (rappdirs::app_dir()$os == "mac") {
    skip("On MacOS these results do differ, no idea why")
  }
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
  testit::assert(!all(file.exists(output_files)))

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
})

test_that("abuse", {

  # Values are checked by 'create_beast2_options'
  # Only need to check for deprecated arguments

  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_log_filename = "irrevant"
    ),
    "output_log_filename.*deprecated"
  )
  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_trees_filenames = "irrevant"
    ),
    "output_trees_filenames.*deprecated"
  )
  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      beast2_working_dir = "irrevant"
    ),
    "beast2_working_dir.*deprecated"
  )
})

test_that("detect errors when BEAST2 is installed", {

  if (!is_beast2_installed()) {
    return()
  }

  expect_error(
    run_beast2(get_beastier_path("anthus_aco.fas")),
    "'input_filename' must be a valid BEAST2 XML file"
  )
})

test_that("BEAST2 does not overwrite the .xml.state file specified by user", {

  if (!is_beast2_installed()) return()

  output_state_filename <- get_beastier_tempfilename(fileext = ".xml.state")

  # Create files to be detectably overwritten
  write(x = "state", file = output_state_filename)
  testit::assert(all(readLines(output_state_filename, warn = FALSE) == "state"))

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
})

test_that("BEAST2 overwrites state file", {

  if (!is_beast2_installed()) return()

  input_filename <- get_beastier_path("2_4.xml")
  output_state_filename <- get_beastier_tempfilename(fileext = ".state")

  # Create files to be detectably overwritten
  write(x = "state", file = output_state_filename)

  testit::assert(all(readLines(output_state_filename) == "state"))

  expect_silent(
    run_beast2(
      input_filename = input_filename,
      output_state_filename = output_state_filename
    )
  )

  # Overwrites all
  expect_true(all(readLines(output_state_filename) != "state"))
  file.remove(output_state_filename)
})

test_that("run BEAST2 from jar path", {

  if (!is_beast2_installed()) {
    return()
  }

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      beast2_path = get_default_beast2_jar_path()
    )
  )
})

test_that("run BEAST2 from binary path", {

  if (!is_beast2_installed()) {
    return()
  }

  # Binary fails under Windows, but works under Unix (see 'use' section above)
  if (rappdirs::app_dir()$os == "unix") {
    expect_silent(
      run_beast2(
        input_filename = get_beastier_path("2_4.xml"),
        beast2_path = get_default_beast2_bin_path()
      )
    )
  }
  # Binary fails under Windows, but works under Unix (see 'use' section above)
  if (rappdirs::app_dir()$os == "win") {
    fake_windows_exe_filename <- file.path(
      get_beastier_tempfilename(),
      "BEAST2.exe"
    )
    testit::assert(is_bin_path(fake_windows_exe_filename))
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
    unlink(dirname(fake_windows_exe_filename), recursive = TRUE)
  }
})

test_that("run_beast2 produces output", {

  if (!is_beast2_installed()) {
    return()
  }
  # From https://stackoverflow.com/a/2501913
  if (rappdirs::app_dir()$os == "win") {
    sink("NUL")
  } else {
    sink("/dev/null")
  }
  output <- run_beast2(get_beastier_path("2_4.xml"), verbose = TRUE)
  sink()
  expect_true(length(output) > 50)
})
