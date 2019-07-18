context("get_alignment_ids")

test_that("use", {

  expect_equal(
    beastier:::get_alignment_ids(get_beastier_path("2_4.xml")),
    c("test_output_0")
  )
  expect_equal(
    beastier:::get_alignment_ids(get_beastier_path("anthus_2_4.xml")),
    c("Anthus_nd2", "Anthus_aco")
  )

})

test_that("use", {

  expect_error(
    beastier:::get_alignment_ids("abs.ent"),
    "'xml_filename' must be the name of an existing file"
  )

})
