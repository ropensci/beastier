context("test-check_beast2_optionses")


test_that("use", {
  expect_silent(check_beast2_optionses(list(create_beast2_options())))

  expect_error(
    check_beast2_optionses(list(create_beast2_options(), "nonsense"))
  )
  expect_error(check_beast2_optionses(create_beast2_options()))
  expect_error(check_beast2_optionses("nonsense"))
  expect_error(check_beast2_optionses(NULL))
  expect_error(check_beast2_optionses(NA))
})
