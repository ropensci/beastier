test_that("deprecation message", {
  expect_error(
    upgrade_beast2(),
    "'beastier::upgrade_beast2' is deprecated"
  )
})
