context("test-run_beast2_from_options")

test_that("use", {

  if (!is_beast2_installed()) {
    return()
  }

  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = get_beastier_path("2_4.xml")
      )
    )
  )
})

test_that("abuse", {
  expect_error(
    run_beast2_from_options(beast2_options = "abs.ent")
  )
})

test_that("local file in temp folder", {

  if (!is_beast2_installed()) {
    return()
  }

  cur_wd <- getwd()
  tmp_wd <- tempfile(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd)
  setwd(tmp_wd)

  # All input and output files will be local
  input_filename <- basename(tempfile(fileext = ".xml"))
  output_log_filename <- basename(tempfile(fileext = ".log"))
  output_trees_filename <- basename(tempfile(fileext = ".trees"))
  output_state_filename <- basename(tempfile(fileext = ".xml.state"))

  # Create input file locally
  file.copy(from = get_beastier_path("2_4.xml"), to = input_filename)

  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = input_filename,
        output_log_filename = output_log_filename,
        output_trees_filenames = output_trees_filename,
        output_state_filename = output_state_filename
      )
    )
  )


  expect_true(file.exists(output_log_filename))
  expect_true(all(file.exists(output_trees_filename)))
  expect_true(file.exists(output_state_filename))


  setwd(cur_wd) # Really do this last
})

test_that("file with full path in temp folder", {

  if (!is_beast2_installed()) {
    return()
  }

  cur_wd <- getwd()
  tmp_wd <- tempfile(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd)
  setwd(tmp_wd)
  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(input_filename = input_filename)

  expect_silent(
    run_beast2_from_options(beast2_options = beast2_options)
  )

  expect_true(file.exists(beast2_options$output_log_filename))
  expect_true(all(file.exists(beast2_options$output_trees_filename)))
  expect_true(file.exists(beast2_options$output_state_filename))

  setwd(cur_wd) # Really do this last
})

test_that("use sub-sub-sub-folders", {

  if (!is_beast2_installed()) return()

  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(input_filename = input_filename)
  beast2_options$output_log_filename <-
    file.path(tempdir(), "a", "b", "c", "d.log")
  beast2_options$output_trees_filenames <-
    file.path(tempdir(), "e", "f", "g", "g.trees")
  beast2_options$output_state_filename <-
    file.path(tempdir(), "h", "i", "j", "k.xml.state")

  expect_silent(
    run_beast2_from_options(beast2_options = beast2_options)
  )

  expect_true(file.exists(beast2_options$output_log_filename))
  expect_true(all(file.exists(beast2_options$output_trees_filename)))
  expect_true(file.exists(beast2_options$output_state_filename))
})
