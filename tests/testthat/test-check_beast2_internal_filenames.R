test_that("multiplication works", {
  beast2_options <- create_beast2_options(
    input_filename = get_beastier_path("2_4.xml")
  )
  bifs <- create_beast2_internal_filenames(
    beast2_options
  )
  expect_silent(check_beast2_internal_filenames(bifs))
})
