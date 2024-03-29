test_that("use, bin", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_bin_path <- get_default_beast2_bin_path()
  input_filename <- "input.xml"

  created <- create_beast2_version_cmd(
    beast2_path = beast2_bin_path
  )
  expected <- c(
    beast2_bin_path,
    "-version"
  )
  expect_equal(created, expected)
  check_empty_beaustier_folders()
})

test_that("use, jar", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()
  beast2_jar_path <- get_default_beast2_jar_path()

  created <- create_beast2_version_cmd(
    beast2_path = beast2_jar_path
  )
  expected <- c(
    get_default_java_path(),
    "-cp",
    paste0("\"", beast2_jar_path, "\""),
    get_beast2_main_class_name(),
    "-version"
  )
  expect_equal(created, expected)
  check_empty_beaustier_folders()
})
