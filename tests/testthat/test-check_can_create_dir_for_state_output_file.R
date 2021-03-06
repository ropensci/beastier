test_that("minimal use", {
  expect_silent(
    check_can_create_dir_for_state_output_file(
      beast2_options = create_beast2_options()
    )
  )
})

test_that("use impossible folder", {
  expect_error(
    check_can_create_dir_for_state_output_file(
      beast2_options = create_beast2_options(
        output_state_filename = "/new_folder_in_root/cannot_work.xml.state"
      )
    ),
    "Cannot create folder"
  )
})
