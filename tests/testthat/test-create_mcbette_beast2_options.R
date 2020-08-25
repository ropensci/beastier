test_that("use", {
  beast2_options <- create_beast2_options()

  mcbette_beast2_options <- create_mcbette_beast2_options()

  expect_true(
    !is.na(
      stringr::str_match(
        string = mcbette_beast2_options$input_filename,
        pattern = "beast2_.*.xml"
      )[1, 1]
    )
  )
  expect_true(
    !is.na(
      stringr::str_match(
        string = mcbette_beast2_options$output_state_filename,
        pattern = "beast2_.*.xml.state"
      )[1, 1]
    )
  )
  expect_true(
    mcbette_beast2_options$overwrite
  )
})
