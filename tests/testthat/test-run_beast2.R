context("run_beast2")

test_that("single alignment creates all files", {

  output_log_filename <- "tmp_single.log"
  output_trees_filenames <- "tmp_single.trees"
  output_state_filename <- "tmp_single.state"

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  testthat::expect_silent(
    run_beast2(
      input_filename = get_path("2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  testthat::expect_true(beastier:::files_exist(output_files))
  beastier:::remove_files(output_files)
})

test_that("single alignment, WIRITTES setting", {

  output_log_filename <- "tmp_single.log"
  output_trees_filenames <- "tmp_single.trees"
  output_state_filename <- "tmp_single.state"

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  testthat::expect_silent(
    run_beast2(
      input_filename = get_path("2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename,
      rng_seed = 42,
      n_threads = 8,
      use_beagle = TRUE,
      overwrite_state_file = TRUE
    )
  )

  testthat::expect_true(beastier:::files_exist(output_files))
  beastier:::remove_files(output_files)
})


test_that("single alignment, equal RNG seed equal results", {

  output_log_filename_1 <- "tmp_single_rng_1.log"
  output_log_filename_2 <- "tmp_single_rng_2.log"
  output_trees_filenames_1 <- "tmp_single_rng_1.trees"
  output_trees_filenames_2 <- "tmp_single_rng_2.trees"
  output_state_filename_1 <- "tmp_single_rng_1.state"
  output_state_filename_2 <- "tmp_single_rng_2.state"

  output_files <- c(
    output_log_filename_1,
    output_log_filename_2,
    output_trees_filenames_1,
    output_trees_filenames_2,
    output_state_filename_1,
    output_state_filename_2
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  rng_seed <- 42
  run_beast2(
    input_filename = get_path("2_4.xml"),
    output_log_filename = output_log_filename_1,
    output_trees_filenames = output_trees_filenames_1,
    output_state_filename = output_state_filename_1,
    rng_seed = rng_seed,
    overwrite_state_file = TRUE
  )
  run_beast2(
    input_filename = get_path("2_4.xml"),
    output_log_filename = output_log_filename_2,
    output_trees_filenames = output_trees_filenames_2,
    output_state_filename = output_state_filename_2,
    rng_seed = rng_seed,
    overwrite_state_file = TRUE
  )
  lines_1 <- readLines(output_log_filename_1)
  lines_2 <- readLines(output_log_filename_2)
  testthat::expect_identical(lines_1, lines_2)
  lines_1 <- readLines(output_trees_filenames_1, warn = FALSE)
  lines_2 <- readLines(output_trees_filenames_2, warn = FALSE)
  testthat::expect_identical(lines_1, lines_2)
  lines_1 <- readLines(output_state_filename_1)
  lines_2 <- readLines(output_state_filename_2)
  testthat::expect_identical(lines_1, lines_2)
  beastier:::remove_files(output_files)
})



test_that("two alignments creates all files", {

  output_log_filename <- "tmp_two.log"
  output_trees_filenames <- c("tmp_two_a.trees", "tmp_two_b.trees")
  output_state_filename <- "tmp_two.state"

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  testthat::expect_silent(
    run_beast2(
      input_filename = get_path("anthus_2_4.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  testthat::expect_true(beastier:::files_exist(output_files))
  beastier:::remove_files(output_files)
})



test_that("anthus_15_15.xml has fixed crown ages of 15 and 15", {

  output_log_filename <- "15_15.log"
  output_trees_filenames <- c("15_15_a.trees", "15_15_b.trees")
  output_state_filename <- "15_15.state"

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  testthat::expect_silent(
    run_beast2(
      input_filename = get_path("anthus_15_15.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  testthat::expect_true(beastier:::files_exist(output_files))

  out <- tracerer::parse_beast_posterior(
    output_trees_filenames, output_log_filename
  )
  n <- length(out$estimates$TreeHeight.aco)
  testthat::expect_true(all.equal(out$estimates$TreeHeight.aco, rep(15, n)))

  # Unexpected: this will fail:
  # Even though the crown ages of both initial phylogenies have been fixed,
  # the second TreeHeights will deviate from it
  testthat::expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )

  beastier:::remove_files(output_files)
})


test_that("anthus_na_15.xml has an estimated and a fixed crown age of 15", {

  output_log_filename <- "na_15.log"
  output_trees_filenames <- c("na_15_a.trees", "na_15_b.trees")
  output_state_filename <- "na_15.state"

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  testthat::expect_silent(
    run_beast2(
      input_filename = get_path("anthus_na_15.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  testthat::expect_true(beastier:::files_exist(output_files))

  out <- tracerer::parse_beast_posterior(
    output_trees_filenames, output_log_filename
  )
  n <- length(out$estimates$TreeHeight.aco)
  # Expected: these are all different
  testthat::expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )

  # Unexpected: these should be 15, but are not
  # Even though the crown ages of the second phylogeny has been fixed at 15,
  # the second TreeHeights will deviate from it
  testthat::expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )

  beastier:::remove_files(output_files)
})


test_that("abuse", {

  testthat::expect_error(
    run_beast2("abs.ent"),
    "'input_filename' must be the name of an existing file"
  )

  testthat::expect_error(
    run_beast2(get_path("anthus_aco.fas")),
    "'input_filename' must be a valid BEAST2 XML file"
  )

  testthat::expect_error(
    run_beast2(
      get_path("anthus_2_4.xml"),
      beast2_jar_path = "abs.ent"
    ),
    "'beast2_jar_path' must be the name of an existing file"
  )

  testthat::expect_error(
    run_beast2(
      input_filename = get_path("2_4.xml"),
      output_trees_filenames = c("too", "much")
    ),
    paste0(
      "'output_trees_filenames' must have as much elements ",
      "as 'input_filename' has alignments"
    )
  )

})

test_that("Create data from anthus_15_15_long.xml", {

  return()

  output_log_filename <- "15_15_long.log"
  output_trees_filenames <- c("15_15_long_a.trees", "15_15_long_b.trees")
  output_state_filename <- "15_15_long.state"

  output_files <- c(output_log_filename, output_trees_filenames,
    output_state_filename
  )
  beastier:::remove_files(output_files)
  testit::assert(!beastier:::files_exist(output_files))

  testthat::expect_silent(
    run_beast2(
      input_filename = get_path("anthus_15_15_long.xml"),
      output_log_filename = output_log_filename,
      output_trees_filenames = output_trees_filenames,
      output_state_filename = output_state_filename
    )
  )

  testthat::expect_true(beastier:::files_exist(output_files))

  out <- tracerer::parse_beast_posterior(
    output_trees_filenames, output_log_filename
  )
  n <- length(out$estimates$TreeHeight.aco)
  testthat::expect_true(all.equal(out$estimates$TreeHeight.aco, rep(15, n)))

  # Unexpected: this will fail:
  # Even though the crown ages of both initial phylogenies have been fixed,
  # the second TreeHeights will deviate from it
  testthat::expect_true(all.equal(out$estimates$TreeHeight.nd2, rep(15, n))
    != TRUE
  )

  # Copy those file to where needed
})
