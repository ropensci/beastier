test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  expect_silent(
    check_input_filename_validity(
      beast2_options = create_beast2_options(
        input_filename = get_beast2_example_filename("testJukesCantor.xml")
      )
    )
  )
})
