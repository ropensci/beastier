test_that("use", {
  check_empty_beaustier_folders()

  beast2_input_filename <- beastier::create_temp_input_filename()
  treelog_filename <- file.path(
    beastier::get_beastier_tempfilename(),
    "sub",
    "tree.log"
  )
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_fasta_filename(),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        treelog = create_treelog(
          filename = treelog_filename
        )
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_false(dir.exists(dirname(treelog_filename)))
  create_beast2_treelog_folder(beast2_options = beast2_options)
  expect_true(dir.exists(dirname(treelog_filename)))
  file.remove(beast2_input_filename)
  unlink(dirname(treelog_filename), recursive = TRUE)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})
