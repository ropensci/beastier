context("run_beast2")

test_that("single alignment creates all files", {


  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- tempfile(fileext = ".trees")
  output_state_filename <- tempfile(fileext = ".xml.state")
  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!beastier:::files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename,
      overwrite = TRUE
    )
  )

  expect_true(beastier:::files_exist(output_files))
})

test_that("single alignment, WIRITTES setting", {

  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- tempfile(fileext = ".trees")
  output_state_filename <- tempfile(fileext = ".xml.state")
  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!beastier:::files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename,
      rng_seed = 42,
      n_threads = 8,
      use_beagle = TRUE,
      overwrite = TRUE
    )
  )

  expect_true(beastier:::files_exist(output_files))
})


test_that("single alignment, equal RNG seed equal results", {

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
  testit::assert(!beastier:::files_exist(output_files))

  rng_seed <- 42
  stdout_1 <- run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_log_filename = output_log_filename_1,
    output_trees_filenames = output_trees_filenames_1,
    output_state_filename = output_state_filename_1,
    rng_seed = rng_seed,
    overwrite = TRUE
  )
  stdout_2 <- run_beast2(
    input_filename = get_beastier_path("2_4.xml"),
    output_log_filename = output_log_filename_2,
    output_trees_filenames = output_trees_filenames_2,
    output_state_filename = output_state_filename_2,
    rng_seed = rng_seed,
    overwrite = TRUE
  )
  expect_equal(length(stdout_1), length(stdout_2))
  expect_equal(2, sum(stdout_1 != stdout_2))
  expect_true(
    all(
      !is_one_na(
        stringr::str_match(
          string = stdout_1[stdout_1 != stdout_2][1],
          pattern = "^Writing state to file"
        )
      )
    )
  )
  expect_true(
    all(
      !is_one_na(
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

  lines_1 <- readLines(output_trees_filenames_1, warn = FALSE)
  lines_2 <- readLines(output_trees_filenames_2, warn = FALSE)
  expect_identical(lines_1, lines_2)

  lines_1 <- readLines(output_state_filename_1)
  lines_2 <- readLines(output_state_filename_2)
  expect_identical(lines_1, lines_2)
})



test_that("two alignments creates all files", {

  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- c(
    tempfile(fileext = "_a.trees"),
    tempfile(fileext = "_b.trees")
  )
  output_state_filename <- tempfile(fileext = ".xml.state")
  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!beastier:::files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("anthus_2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename,
      overwrite = TRUE
    )
  )

  expect_true(beastier:::files_exist(output_files))
})

test_that("anthus_15_15.xml has fixed crown ages of 15 and 15", {

  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- c(
    tempfile(fileext = "_a.trees"),
    tempfile(fileext = "_b.trees")
  )
  output_state_filename <- tempfile(fileext = ".xml.state")
  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!beastier:::files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("anthus_15_15.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename,
      overwrite = TRUE
    )
  )

  expect_true(beastier:::files_exist(output_files))

  out <- tracerer::parse_beast_posterior(
    output_trees_filenames, output_log_filename
  )
  n <- length(out$estimates$TreeHeight.aco)
  expect_true(all.equal(out$estimates$TreeHeight.aco, rep(15, n)))

  # Unexpected: this will fail:
  # Even though the crown ages of both initial phylogenies have been fixed,
  # the second TreeHeights will deviate from it
  expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )
})


test_that("anthus_na_15.xml has an estimated and a fixed crown age of 15", {

  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- c(
    tempfile(fileext = "_a.trees"),
    tempfile(fileext = "_b.trees")
  )
  output_state_filename <- tempfile(fileext = ".xml.state")
  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!beastier:::files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("anthus_na_15.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename,
      overwrite = TRUE
    )
  )

  expect_true(beastier:::files_exist(output_files))

  out <- tracerer::parse_beast_posterior(
    output_trees_filenames, output_log_filename
  )
  n <- length(out$estimates$TreeHeight.aco)
  # Expected: these are all different
  expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )

  # Unexpected: these should be 15, but are not
  # Even though the crown ages of the second phylogeny has been fixed at 15,
  # the second TreeHeights will deviate from it
  expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )
})


test_that("abuse", {

  expect_error(
    run_beast2("abs.ent"),
    "'input_filename' must be the name of an existing file"
  )

  expect_error(
    run_beast2(get_beastier_path("anthus_aco.fas")),
    "'input_filename' must be a valid BEAST2 XML file"
  )

  expect_error(
    run_beast2(
      get_beastier_path("anthus_2_4.xml"),
      beast2_path = "abs.ent"
    ),
    "'beast2_path' must be the name of an existing file"
  )

  expect_error(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      output_trees_filenames = c("too", "much")
    ),
    paste0(
      "'output_trees_filenames' must have as much elements ",
      "as 'input_filename' has alignments"
    )
  )

  expect_silent(
    run_beast2(
      get_beastier_path("anthus_2_4.xml"),
      rng_seed = 1,
      overwrite = TRUE
    )
  )
  expect_silent(
    run_beast2(
      get_beastier_path("anthus_2_4.xml"),
      rng_seed = NA,
      overwrite = TRUE
    )
  )
  expect_error(
    run_beast2(
      get_beastier_path("anthus_2_4.xml"),
      rng_seed = 0,
      overwrite = TRUE
    ),
    "'rng_seed' should be one NA or one non-zero positive value"
  )
})

test_that("Create data from anthus_15_15_long.xml", {

  return()

  output_log_filename <- tempfile(fileext = ".log")
  output_trees_filenames <- c(
    tempfile(fileext = "_a.trees"),
    tempfile(fileext = "_b.trees")
  )
  output_state_filename <- tempfile(fileext = ".xml.state")

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  testit::assert(!beastier:::files_exist(output_files))

  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("anthus_15_15_long.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  expect_true(beastier:::files_exist(output_files))

  out <- tracerer::parse_beast_posterior(
    output_trees_filenames, output_log_filename
  )
  n <- length(out$estimates$TreeHeight.aco)
  expect_true(all.equal(out$estimates$TreeHeight.aco, rep(15, n)))

  # Unexpected: this will fail:
  # Even though the crown ages of both initial phylogenies have been fixed,
  # the second TreeHeights will deviate from it
  expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )
  # Copy those file to where needed
})

test_that("BEAST2 does not overwrite the log file specified by the user", {

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

test_that("BEAST2 does not overwrite its own log file", {

  input_filename <- get_beastier_path("2_4.xml")

  beast_log_file <- beastier:::create_default_log_filename(input_filename)
  if (file.exists(beast_log_file)) {
    file.remove(beast_log_file)
  }
  testit::assert(!file.exists(beast_log_file))

  # Create files to be detectably overwritten
  write(
    x = "log",
    file = beastier:::create_default_log_filename(input_filename)
  )

  expect_error(
    run_beast2(
      input_filename = input_filename,
      output_log_filename = tempfile(fileext = ".log"),
      overwrite = FALSE
    ),
    paste0(
      "Cannot overwrite the .log file created by BEAST2 ",
      "\\('test_output_0.log'\\) with 'overwrite' is FALSE"
    )
  )
})

test_that("BEAST2 does not overwrite its own trees file", {

  input_filename <- get_beastier_path("2_4.xml")

  # First remove the other BEAST2 file
  beast_log_file <- beastier:::create_default_log_filename(input_filename)
  if (file.exists(beast_log_file)) {
    file.remove(beast_log_file)
  }
  testit::assert(!file.exists(beast_log_file))

  beast_trees_file <- beastier:::create_default_trees_filenames(input_filename)
  if (file.exists(beast_trees_file)) {
    file.remove(beast_trees_file)
  }
  testit::assert(!file.exists(beast_trees_file))

  # Create files to be detectably overwritten
  write(
    x = "trees",
    file = beastier:::create_default_trees_filenames(input_filename)
  )

  expect_error(
    run_beast2(
      input_filename = input_filename,
      output_trees_filenames = tempfile(fileext = ".trees"),
      overwrite = FALSE
    ),
    paste0(
      "Cannot overwrite the .trees files created by BEAST2 ",
      "\\('test_output_0.trees'\\) with 'overwrite' is FALSE"
    )
  )
})

test_that("BEAST2 overwrites log and trees files", {

  input_filename <- get_beastier_path("2_4.xml")
  output_log_filename <- beastier:::create_default_log_filename(
    input_filename = input_filename,
    beast2_path = get_default_beast2_path(),
    verbose = FALSE
  )
  output_trees_filename <- beastier:::create_default_trees_filenames(
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
  expect_silent(
    run_beast2(
      input_filename = get_beastier_path("2_4.xml"),
      beast2_path = get_default_beast2_jar_path()
    )
  )
})

test_that("run BEAST2 from binary path", {

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
  expect_error(
    run_beast2(
      input_filename = beastier:::get_beastier_path("beast2_warning.xml"),
      beast2_path = "BEAST.exe"
    ),
    "Cannot use the Windows executable BEAST2.exe in scripts"
  )

})

test_that("run_beast2 produces output", {
  output <- run_beast2(get_beastier_path("2_4.xml"), verbose = TRUE)
  expect_true(length(output) > 50)
})
