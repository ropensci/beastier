test_that("minimal use", {
  expect_silent(
    check_can_create_state_output_file(
      beast2_options = create_beast2_options()
    )
  )
})

test_that("use impossible folder", {
  # On Windows, this test will pass
  if (rappdirs::app_dir()$os == "win") return()

  expect_error(
    check_can_create_state_output_file(
      beast2_options = create_beast2_options(
        output_state_filename = "/cannot_work.xml.state"
      )
    ),
    "Cannot create BEAST2 .xml.state output file"
  )
})
