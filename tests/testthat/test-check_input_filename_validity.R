test_that("use", {
  if (!is_beast2_installed()) return()
  expect_silent(
    check_input_filename_validity(
      beast2_options = create_beast2_options(
        input_filename = get_beast2_example_filename("testJukesCantor.xml")
      )
    )
  )
})

test_that("deprecation", {
  expect_error(
    check_input_filename_validity(
      beast2_options = create_beast2_options(
        input_filename = get_beast2_example_filename("testJukesCantor.xml")
      ),
      input_filename = "should_not_use"
    ),
    "input_filename..is deprecated"
  )
  expect_error(
    check_input_filename_validity(
      beast2_options = create_beast2_options(
        input_filename = get_beast2_example_filename("testJukesCantor.xml")
      ),
      beast2_path = "should_not_use"
    ),
    "beast2_path..is deprecated"
  )
  expect_error(
    check_input_filename_validity(
      beast2_options = create_beast2_options(
        input_filename = get_beast2_example_filename("testJukesCantor.xml")
      ),
      verbose = "should_not_use"
    ),
    "verbose..is deprecated"
  )
})
