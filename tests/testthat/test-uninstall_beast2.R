test_that("uninstall absent BEAST2 must throw", {

  expect_error(
    uninstall_beast2(folder_name = "/abs/ent"), # nolint use an absolute path here
    "Cannot uninstall absent BEAST2 at"
  )
})

test_that("uninstall must be silent", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()

  folder_name <- tempfile(pattern = "beastier_")
  expect_silent(install_beast2(folder_name = folder_name))
  expect_silent(uninstall_beast2(folder_name = folder_name))
  expect_true(!dir.exists(folder_name))
})

test_that("install can be verbose", {

  if (!is_on_ci()) return()
  if (rappdirs::app_dir()$os == "mac") return()

  folder_name <- tempfile(pattern = "beastier_")
  expect_silent(install_beast2(folder_name = folder_name))
  expect_message(
    uninstall_beast2(folder_name = folder_name, verbose = TRUE),
    "Uninstalling BEAST2"
  )
  expect_true(!dir.exists(folder_name))
})
