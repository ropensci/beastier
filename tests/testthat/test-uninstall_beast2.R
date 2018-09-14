context("uninstall_beast2")

test_that("uninstall absent BEAST2 must throw", {

  folder_name <- tempdir()
  expect_error(
    uninstall_beast2(folder_name),
    "Cannot uninstall absent BEAST2 at"
  )
})
