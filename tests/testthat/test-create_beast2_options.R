test_that("use", {
  expect_silent(create_beast2_options())
})

test_that("increase stack space", {
  skip("Issue 60")
  # Result in same behavior
  expect_silent(
    create_beast2_options(
      stack_size_kb = NA
    )
  )
  # 320k stack size
  expect_silent(
    create_beast2_options(
      stack_size_kb = 320
    )
  )
  # Must be positive
  expect_error(
    create_beast2_options(
      stack_size_kb = -1234567
    )
  )
  expect_error(
    create_beast2_options(
      stack_size_kb = 0
    )
  )
  expect_error(
    create_beast2_options(
      stack_size_kb = Inf
    )
  )
})

# BEAST2 working dir and folder for filenames must differ
# is tested by test-check_beast2_options_filenames_not_in_working_dir.R

test_that("deprecated variables", {

  expect_error(
    create_beast2_options(
      output_log_filename = "should_not_use"
    ),
    "'output_log_filename' is deprecated, it is stored in the BEAST2 XML"
  )

  expect_error(
    create_beast2_options(
      output_trees_filenames = "should_not_use"
    ),
    "'output_trees_filenames' is deprecated, it is stored in the BEAST2 XML"
  )
  expect_error(
    create_beast2_options(
      beast2_working_dir = "should_not_use"
    ),
    "'beast2_working_dir' is deprecated"
  )
})
