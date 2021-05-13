test_that("all is fine", {
  beast2_input_filename <- tempfile()
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_beautier_path("test_output_0.fas"),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        treelog = create_treelog(filename = tempfile("OK"))
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_silent(
    check_can_create_treelog_file(beast2_options)
  )
})

test_that("use", {
  beast2_input_filename <- tempfile()
  beautier::create_beast2_input_file_from_model(
    input_filename = beautier::get_beautier_path("test_output_0.fas"),
    output_filename = beast2_input_filename,
    inference_model = create_test_inference_model(
      mcmc = create_test_mcmc(
        treelog = create_treelog(filename = "/cannot_write_to_root.trees")
      )
    )
  )
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_filename
  )
  expect_error(
    check_can_create_treelog_file(beast2_options),
    "Cannot create treelog file"
  )
})
