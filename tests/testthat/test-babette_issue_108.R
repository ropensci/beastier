test_that("use", {
  fasta_filename <- beautier::get_beautier_path("babette_issue_108.fasta")
  output_filename <- beautier::get_beautier_tempfilename()
  tipdates_filename <- beautier::get_beautier_path(
    "babette_issue_108_tipdates.txt"
  )
  create_beast2_input_file(
    fasta_filename,
    output_filename,
    tipdates_filename = tipdates_filename,
    clock_model = create_rln_clock_model(),
    site_model = create_gtr_site_model(),
    mcmc = create_mcmc(chain_length = 1000),
    tree_prior = create_cbs_tree_prior(),
    beauti_options = beautier::create_beauti_options_v2_6()
  )
  expect_true(file.exists(output_filename))
  expect_true(file.exists(tipdates_filename))
  readr::read_lines(output_filename)

  if (1 == 2) {
    beastier::run_beast2(
      input_filename = output_filename,
      output_state_filename = create_temp_state_filename(),
      use_beagle = TRUE
    )
  }

  remove_beaustier_folders()
})
