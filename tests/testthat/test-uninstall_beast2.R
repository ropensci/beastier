context("uninstall_beast2")

test_that("uninstall absent BEAST2 must throw", {

  expect_error(
    uninstall_beast2(folder_name = "/abs/ent"), # nolint use an absolute path here
    "Cannot uninstall absent BEAST2 at"
  )
})
