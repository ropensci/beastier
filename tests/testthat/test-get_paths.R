context("get_paths")

test_that("use", {

  testthat::expect_equal(
    length(
      lumier::get_paths(
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
