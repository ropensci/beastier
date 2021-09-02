test_that("use", {
  beast2_input_filename <- beastier::create_temp_input_filename()
  screenlog_filename <- file.path(
    beastier::get_beastier_tempfilename(),
    "sub",
    "screen.log"
  )
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_fasta_filename(),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        screenlog = create_screenlog(
          filename = screenlog_filename
        )
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_false(dir.exists(dirname(screenlog_filename)))
  create_beast2_screenlog_folder(beast2_options = beast2_options)
  expect_true(dir.exists(dirname(screenlog_filename)))
  file.remove(beast2_input_filename)
  unlink(dirname(screenlog_filename), recursive = TRUE)
})
