test_that("minimal use", {
  expect_silent(
    check_can_create_state_output_file(
      beast2_options = create_beast2_options()
    )
  )
})

test_that("use impossible folder", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  # On Windows, this test will pass
  skip_on_os(os = "windows")

  expect_error(
    check_can_create_state_output_file(
      beast2_options = create_beast2_options(
        output_state_filename = "/cannot_work.xml.state"
      )
    ),
    "Cannot create BEAST2 .xml.state output file"
  )
})
