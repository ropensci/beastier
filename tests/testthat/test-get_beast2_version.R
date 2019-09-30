test_that("use", {
  if (!is_beast2_installed()) return()

  expect_equal(get_beast2_version(), "2.6.0")
})

test_that("abuse", {
  if (!is_beast2_installed()) return()

  expect_error(
    get_beast2_version(
      beast2_path = "abs.ent"
    ),
    "'beast2_path' must be the full path of either 'beast' or 'launcher.jar'"
  )
})
