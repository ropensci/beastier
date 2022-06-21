test_that("use", {
  check_empty_beaustier_folders()

  expect_silent(create_beast2_options())

  check_empty_beaustier_folders()
})

test_that("increase stack space", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  skip("Issue 60, Issue #60")

  check_empty_beaustier_folders()

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
  # Note that the exact error message is tested in 'test-check_stack_size_kb'
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

  check_empty_beaustier_folders()
})
