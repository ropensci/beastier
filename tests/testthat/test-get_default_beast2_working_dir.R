test_that("use", {
  expect_equal(
    get_default_beast2_working_dir(),
    file.path(rappdirs::user_cache_dir(), "beastier")
  )
})
