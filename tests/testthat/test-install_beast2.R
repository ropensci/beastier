test_that("deprecation message", {
  expect_error(
    install_beast2(),
    "'beastier::install_beast2' is deprecated"
  )
})
