test_that("use", {
  skip("Fix Issue 60, Fix Issue #60")
  # Hi Jeff, here I suggest to add 'check_stack_size_kb',
  # you will probably get the same idea after
  # reading 'check_beast2_options_data_types'
  expect_silent(check_stack_size_kb(stack_size_kb = 1234))
  expect_error(
    check_stack_size_kb(stack_size_kb = 0),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = -1234),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = NA),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = "nonsense"),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = NULL),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = Inf),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = c()),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
  expect_error(
    check_stack_size_kb(stack_size_kb = c(1, 2)),
    "'stack_size_kb' must be one non-zero, finite and positive number"
  )
})
