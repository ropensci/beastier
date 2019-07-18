context("get_trees_filenames")

test_that("use", {

  expect_equal(
    get_trees_filenames(get_beastier_path("2_4.xml")),
    "test_output_0.trees"
  )

  expect_equal(
    get_trees_filenames(get_beastier_path("anthus_2_4.xml")),
    c("Anthus_nd2.trees", "Anthus_aco.trees")
  )

})
