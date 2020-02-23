test_that("use", {

  if (!is_beast2_installed()) return()

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

  if (!is_beast2_installed()) return()

  cur_wd <- getwd()
  tmp_wd <- tempfile(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd)
  setwd(tmp_wd)

  # All input and output files will be local
  input_filename <- basename(tempfile(fileext = ".xml"))
  output_state_filename <- basename(tempfile(fileext = ".xml.state"))

  # Create input file locally
  file.copy(from = get_beastier_path("2_4.xml"), to = input_filename)

  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = input_filename,
        output_state_filename = output_state_filename
      )
    )
  )


  expect_true(file.exists(output_state_filename))


  setwd(cur_wd) # Really do this last
})

test_that("file with full path in temp folder", {

  if (!is_beast2_installed()) return()

  cur_wd <- getwd()
  tmp_wd <- tempfile(pattern = "beast2_tmp_folder")
  dir.create(tmp_wd)
  setwd(tmp_wd)
  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(input_filename = input_filename)

  expect_silent(
    run_beast2_from_options(beast2_options = beast2_options)
  )

  expect_true(file.exists(beast2_options$output_state_filename))

  setwd(cur_wd) # Really do this last
})

test_that("use sub-sub-sub-folders", {

  if (!is_beast2_installed()) return()

  input_filename <- get_beastier_path("2_4.xml")
  beast2_options <- create_beast2_options(input_filename = input_filename)
  beast2_options$output_state_filename <-
    file.path(tempdir(), "h", "i", "j", "k.xml.state")

  expect_silent(
    run_beast2_from_options(beast2_options = beast2_options)
  )

  expect_true(file.exists(beast2_options$output_state_filename))
})


test_that("show proper error message when using CBS with too few taxa", {

  if (!is_beast2_installed()) return()

  # Prepare XML file for beastier
  fasta_filename <- beastier::get_beastier_path("test_output_2.fas")
  beast2_input_file <- tempfile(fileext = ".xml")

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
})


test_that("BEAST2 freezes when treelog file already exists", {

  skip("Issue 50, Issue #50")

  if (!is_beast2_installed()) return()

  beast2_xml_filename <- tempfile(
    pattern = "beast2_", tmpdir = rappdirs::user_cache_dir(),
    fileext = ".xml"
  )

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

})

test_that("use", {

  if (!is_beast2_installed()) return()

  fake_win_filename <- file.path(tempdir(), "BEAST2.exe")
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
})

test_that("use tildes instead of full path", {

  if (!is_beast2_installed()) return()

  skip("Issue 53. Issue #53")

  # Copy a file to the home folder, must be deleted in the end
  file.copy(from = get_beastier_path("2_4.xml"), "~/2_4.xml")
  expect_true(file.exists("~/2_4.xml"))

  expect_silent(
    run_beast2_from_options(
      create_beast2_options(
        input_filename = "~/2_4.xml",
        output_state_filename = "~/output.xml",

      )
    )
  )
})
