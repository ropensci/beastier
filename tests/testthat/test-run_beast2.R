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
      beast_jar_path = "abs.ent"
    ),
    "'beast_jar_path' must be the name of an existing file"
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
