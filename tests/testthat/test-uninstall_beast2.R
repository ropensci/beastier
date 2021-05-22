test_that("deprecation message", {
  expect_error(
    uninstall_beast2(),
    "'beastier::uninstall_beast2' is deprecated"
  )
})
