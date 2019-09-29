context("run_beast2")

test_that("single alignment creates all files", {

  if (!is_beast2_installed()) return()

  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- tempfile(fileext = ".trees")
  output_state_filename <- tempfile(fileext = ".xml.state")
  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  expect_true(files_exist(output_files))
})

test_that("single alignment, equal RNG seed equal results", {

  if (!is_beast2_installed()) return()

  output_log_filename_1 <- tempfile(fileext = "_1.log")
  output_log_filename_2 <- tempfile(fileext = "_2.log")
  output_trees_filenames_1 <- tempfile(fileext = "_1.trees")
  output_trees_filenames_2 <- tempfile(fileext = "_2.trees")
  output_state_filename_1 <- tempfile(fileext = "_1.xml.state")
  output_state_filename_2 <- tempfile(fileext = "_2.xml.state")
  output_files <- c(
    output_log_filename_1,
    output_log_filename_2,
    output_trees_filenames_1,
    output_trees_filenames_2,
    output_state_filename_1,
    output_state_filename_2
  )
  testit::assert(!files_exist(output_files))

  rng_seed <- 42
  stdout_1 <- run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_log_filename = output_log_filename_1,
    output_trees_filenames = output_trees_filenames_1,
    output_state_filename = output_state_filename_1,
    rng_seed = rng_seed
  )
  stdout_2 <- run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_log_filename = output_log_filename_2,
    output_trees_filenames = output_trees_filenames_2,
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
  lines_1 <- readLines(output_log_filename_1)
  lines_2 <- readLines(output_log_filename_2)
  expect_identical(lines_1, lines_2)

  lines_1 <- readLines(output_state_filename_1)
  lines_2 <- readLines(output_state_filename_2)
  expect_identical(lines_1, lines_2)
})

test_that("detect errors when BEAST2 need not be installed", {

  expect_error(
    run_beast2("abs.ent"),
    "File '.*' not found"
  )

  expect_error(
    run_beast2(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "abs.ent"
    ),
    "File '.*' not found"
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


  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_trees_filenames = c("too", "much")
    ),
    "output_trees_filenames"
  )

  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      rng_seed = 0
    ),
    "'rng_seed' should be one NA or one non-zero positive value"
  )

  expect_silent(
    run_beast2(
      get_beastier_path("2_4.xml"),
      rng_seed = 1
    )
  )
  expect_silent(
    run_beast2(
      get_beastier_path("2_4.xml"),
      rng_seed = NA
    )
  )
})

test_that("BEAST2 does not overwrite the log file specified by the user", {

  if (!is_beast2_installed()) {
    return()
  }

  output_log_filename <- tempfile(fileext = ".log")

  # Create files to be detectably overwritten
  write(x = "log", file = output_log_filename)
  testit::assert(all(readLines(output_log_filename) == "log"))

  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_log_filename = output_log_filename,
      overwrite = FALSE
    ),
    "Will not overwrite 'output_log_filename'"
  )
})

test_that("BEAST2 does not overwrite the .trees file specified by the user", {

  if (!is_beast2_installed()) {
    return()
  }

  output_trees_filename <- tempfile(fileext = ".trees")

  # Create files to be detectably overwritten
  write(x = "trees", file = output_trees_filename)
  testit::assert(all(readLines(output_trees_filename, warn = FALSE) == "trees"))

  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_log_filename = tempfile(fileext = ".log"),
      output_trees_filenames = output_trees_filename,
      overwrite = FALSE
    ),
    "Will not overwrite 'output_trees_filenames'"
  )
})

test_that("BEAST2 does not overwrite the .xml.state file specified by user", {

  if (!is_beast2_installed()) {
    return()
  }

  output_state_filename <- tempfile(fileext = ".xml.state")

  # Create files to be detectably overwritten
  write(x = "state", file = output_state_filename)
  testit::assert(all(readLines(output_state_filename, warn = FALSE) == "state"))

  # Delete the log file iff it is present,
  # only needed when running these tests locally for multiple times
  input_filename <- get_beastier_path("2_4.xml")
  output_log_filename <- create_default_log_filename(input_filename)
  if (file.exists(output_log_filename)) file.remove(output_log_filename)

  # Delete the trees file iff it is present,
  # only needed when running these tests locally for multiple times
  output_trees_filenames <- create_default_trees_filenames(input_filename)
  if (any(file.exists(output_trees_filenames))) {
    file.remove(output_trees_filenames)
  }

  expect_error(
    run_beast2(
      input_filename = input_filename,
      output_state_filename = output_state_filename,
      output_trees_filenames = output_trees_filenames,
      output_log_filename = output_log_filename,
      overwrite = FALSE
    ),
    "Will not overwrite 'output_state_filename'"
  )
})

test_that("BEAST2 overwrites log and trees files", {

  if (!is_beast2_installed()) {
    return()
  }
  input_filename <- get_beastier_path("2_4.xml")
  output_log_filename <- create_default_log_filename(
    input_filename = input_filename,
    beast2_path = get_default_beast2_path(),
    verbose = FALSE
  )
  output_trees_filename <- create_default_trees_filenames(
    input_filename = input_filename,
    beast2_path = get_default_beast2_path(),
    verbose = FALSE
  )
  output_state_filename <- tempfile(fileext = ".state")

  # Create files to be detectably overwritten
  write(x = "log", file = output_log_filename)
  write(x = "trees", file = output_trees_filename)
  write(x = "state", file = output_state_filename)

  testit::assert(all(readLines(output_log_filename) == "log"))
  testit::assert(all(readLines(output_trees_filename, warn = FALSE) == "trees"))
  testit::assert(all(readLines(output_state_filename) == "state"))

  expect_silent(
    run_beast2(
      input_filename = input_filename,
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filename,
      output_state_filename = output_state_filename,
      overwrite = TRUE
    )
  )

  # Overwrites all
  expect_true(all(readLines(output_log_filename) != "log"))
  expect_true(all(readLines(output_trees_filename, warn = FALSE) != "trees"))
  expect_true(all(readLines(output_state_filename) != "state"))
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
    fake_windows_exe_filename <- file.path(tempfile(), "BEAST2.exe")
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
      "Cannot use the Windows executable BEAST2.exe in scripts"
    )
  }
})

test_that("run_beast2 produces output", {

  if (!is_beast2_installed()) {
    return()
  }
  output <- run_beast2(get_beastier_path("2_4.xml"), verbose = TRUE)
  expect_true(length(output) > 50)
})

test_that("run_beast2 with that cannot write to target directory", {

  if (!is_beast2_installed()) return()
  expect_error(
    run_beast2(get_beastier_path("2_4.xml"), beast2_working_dir = "/"),
    paste0(
      "BEAST2 \\.log file not created at '//test_output_0.log' \n",
      "Maybe no permission to write at that location?"
    )
  )
})

test_that("run_beast2 with invalid working directory", {

  if (!is_beast2_installed()) return()

  beast2_working_dir <- "/no/way"
  if (rappdirs::app_dir()$os == "win") {
    beast2_working_dir <- "C:\\Windows"
  }

  # When creating an invalid working directory,
  # this gives both a warning and an error.
  # Here, I test for the error and suppress the warning
  suppressWarnings(
    expect_error(
      run_beast2(
        input_filename = get_beastier_path("2_4.xml"),
        beast2_working_dir = beast2_working_dir
      ),
      "no permission"
    )
  )
})
