test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )

  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2_from_options(
    beast2_options = beast2_options
  )
  file.remove(beast2_options$output_state_filename)

  remove_beaustier_folders()
  check_empty_beastier_folder()
})

test_that("abuse", {
  expect_silent(check_empty_beastier_folder())

  expect_error(
    run_beast2_from_options(beast2_options = "abs.ent")
  )
  expect_silent(check_empty_beastier_folder())
})

test_that("local file in temp folder", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  cur_wd <- getwd()
  tmp_wd <- get_beastier_tempfilename(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd, showWarnings = FALSE, recursive = TRUE)
  setwd(tmp_wd) # nolint really need this

  # All input and output files will be local
  input_filename <- basename(
    get_beastier_tempfilename(fileext = ".xml")
  )
  output_state_filename <- basename(
    get_beastier_tempfilename(fileext = ".xml.state")
  )

  # Create input file locally
  file.copy(from = get_beastier_path("2_4.xml"), to = input_filename)

  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2_from_options(
    beast2_options = create_beast2_options(
      input_filename = input_filename,
      output_state_filename = output_state_filename
    )
  )

  expect_true(file.exists(input_filename))
  expect_true(file.exists(output_state_filename))
  file.remove(input_filename)
  file.remove(output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()

  setwd(cur_wd) # Really do this last # nolint really need this
})

test_that("file with full path in temp folder", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  skip("This test takes unexpectedly long")

  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  cur_wd <- getwd()

  tmp_wd <- get_beastier_tempfilename(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd, showWarnings = FALSE, recursive = TRUE)
  setwd(tmp_wd) # nolint really need this
  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(
    input_filename = input_filename
  )

  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2_from_options(beast2_options = beast2_options)

  expect_true(file.exists(beast2_options$output_state_filename))
  file.remove(beast2_options$output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()

  setwd(cur_wd) # Really do this last # nolint really need this
})

test_that("use sub-sub-sub-folder for output_state_filename", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(
    input_filename = input_filename,
    output_state_filename = file.path(
      get_beastier_tempfilename(), "h", "i", "j", "k.xml.state"
    )
  )
  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2_from_options(beast2_options = beast2_options)

  expect_true(file.exists(beast2_options$output_state_filename))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use sub-sub-sub-folder for tracelog, screenlog and treelog", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  mcmc <- beautier::create_test_mcmc(
    tracelog = beautier::create_test_tracelog(
      filename = file.path(
        get_beastier_tempfilename(), "a", "b", "c", "tracelog.csv"
      )
    ),
    screenlog = beautier::create_test_screenlog(
      filename = file.path(
        get_beastier_tempfilename(), "d", "e", "f", "screenlog.txt"
      )
    ),
    treelog = beautier::create_test_treelog(
      filename = file.path(
        get_beastier_tempfilename(), "g", "h", "i", "treelog.trees"
      )
    )
  )
  beast2_options <- beastier::create_beast2_options(
    output_state_filename = file.path(
      get_beastier_tempfilename(), "j", "k", "l", "final.xml.state"
    ),
    verbose = TRUE
  )
  fasta_filename <- beautier::get_beautier_path("anthus_aco.fas")

  inference_model <- create_inference_model(mcmc = mcmc)
  beast2_input_filename <- beastier::create_temp_input_filename()
  beautier::create_beast2_input_file_from_model(
    input_filename = fasta_filename,
    output_filename = beast2_input_filename,
    inference_model = inference_model
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2_from_options(beast2_options = beast2_options)

  file.remove(beast2_input_filename)
  expect_true(file.exists(beast2_options$output_state_filename))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use relative and sub-sub-sub-folders", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(
    input_filename = input_filename,
    output_state_filename = file.path(
      get_beastier_tempfilename(), "h", "i", "..", "j", "k.xml.state"
    )
  )
  # Cannot use 'expect_silent' as an empty line is produced in the output
  run_beast2_from_options(beast2_options = beast2_options)

  expect_true(file.exists(beast2_options$output_state_filename))

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})


test_that("show proper error message when using CBS with too few taxa", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  # Prepare XML file for beastier
  fasta_filename <- beastier::get_beastier_path("test_output_2.fas")
  beast2_input_file <- get_beastier_tempfilename(fileext = ".xml")

  # The error is already detected when creating a BEAST2 input file
  expect_error(
    beautier::create_beast2_input_file(
      input_filename = fasta_filename,
      output_filename = beast2_input_file,
      tree_prior = beautier::create_cbs_tree_prior()
    ),
    "'group_sizes_dimension' .* must be less than the number of taxa"
  )
  # The error is already detected when creating a BEAST2 input file
  expect_error(
    beautier::create_beast2_input_file_from_model(
      input_filename = fasta_filename,
      output_filename = beast2_input_file,
      inference_model = beautier::create_inference_model(
        tree_prior = beautier::create_cbs_tree_prior()
      )
    ),
    "'group_sizes_dimension' .* must be less than the number of taxa"
  )
  expect_false(file.exists(beast2_input_file))

  check_empty_beaustier_folders()
})


test_that("BEAST2 freezes when treelog file already exists", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  skip("Issue 50, Issue #50")

  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_xml_filename <- get_beastier_tempfilename()

  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_fasta_filename(),
    output_filename = beast2_xml_filename,
    inference_model = beautier::create_test_inference_model(
      mcmc = beautier::create_test_mcmc(
        screenlog = beautier::create_screenlog(filename = "")
      )
    )
  )
  testit::assert(file.exists(beast2_xml_filename))

  # First run works fine, takes approx 1 sec on my computer
  beastier::run_beast2_from_options(
    beastier::create_beast2_options(
      input_filename = beast2_xml_filename,
      overwrite = FALSE,
      verbose = TRUE
    )
  )

  # Second run causes BEAST2 to freeze
  beastier::run_beast2_from_options(
    beastier::create_beast2_options(
      input_filename = beast2_xml_filename,
      overwrite = FALSE,
      verbose = TRUE
    )
  )

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  fake_win_filename <- file.path(get_beastier_tempfilename(), "BEAST2.exe")
  dir.create(dirname(fake_win_filename), recursive = TRUE, showWarnings = FALSE)
  file.create(fake_win_filename)
  expect_error(
    run_beast2_from_options(
      beast2_options = create_beast2_options(
        input_filename = get_beastier_path("2_4.xml"),
        beast2_path = fake_win_filename
      )
    ),
    "Cannot use the Windows executable BEAST2.exe in scripts"
  )

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use tildes instead of full path", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  # Copy a file to the home folder, must be deleted in the end
  full_path <- get_beastier_path("2_4.xml")
  relative_in_path <- "~/2_4.xml"
  file.copy(from = full_path, to = relative_in_path)

  # Both files are identical
  expect_equivalent(readLines(full_path), readLines(relative_in_path))
  # Also the relative file is a good BEAST2 file
  expect_true(is_beast2_input_file(relative_in_path))

  relative_out_path <- "~/output.xml"
  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = relative_in_path,
        output_state_filename = relative_out_path,

      )
    )
  )

  expect_true(file.exists(relative_out_path))

  file.remove(relative_in_path)
  file.remove(relative_out_path)
  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("Run with spaces in the input filename, for Windows", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  input_filename <- get_beastier_tempfilename(
    "file with spaces ", fileext = ".xml"
  )
  dir.create(dirname(input_filename), showWarnings = FALSE, recursive = TRUE)
  file.copy(
    from = get_beastier_path("2_4.xml"),
    input_filename
  )
  output_state_filename <- get_beastier_tempfilename()
  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = input_filename,
        output_state_filename = output_state_filename
      )
    )
  )
  expect_true(file.exists(input_filename))
  expect_true(file.exists(output_state_filename))
  file.remove(input_filename)
  file.remove(output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("Run with spaces in the output state filename, for Windows", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  output_state_filename <- get_beastier_tempfilename(
    "file with spaces ", fileext = ".state.xml"
  )

  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = get_beastier_path("2_4.xml"),
        output_state_filename = output_state_filename
      )
    )
  )
  expect_true(file.exists(output_state_filename))
  file.remove(output_state_filename)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
