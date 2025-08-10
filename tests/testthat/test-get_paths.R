test_that("use", {

  expect_equal(
    length(
      beastier::get_beastier_paths(
        c(
          "beast2_example_output.log",
          "beast2_example_output.trees",
          "beast2_example_output.xml",
          "beast2_example_output.xml.state"
        )
      )
    ),
    4
  )
})
