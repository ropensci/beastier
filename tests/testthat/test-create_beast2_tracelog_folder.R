test_that("use", {
  beast2_input_filename <- beastier::create_temp_input_filename()
  tracelog_filename <- file.path(
    beastier::get_beastier_tempfilename(),
    "sub",
    "trace.log"
  )
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_fasta_filename(),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        tracelog = create_tracelog(
          filename = tracelog_filename
        )
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_false(dir.exists(dirname(tracelog_filename)))
  create_beast2_tracelog_folder(beast2_options = beast2_options)
  expect_true(dir.exists(dirname(tracelog_filename)))
  file.remove(beast2_input_filename)
  unlink(dirname(tracelog_filename), recursive = TRUE)
})
