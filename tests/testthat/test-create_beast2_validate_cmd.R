test_that("use, bin", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_bin_path <- get_default_beast2_bin_path()
  input_filename <- "input.xml"

  created <- create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_bin_path
  )
  expected <- c(
    beast2_bin_path,
    "-validate",
    input_filename
  )
  expect_equal(created, expected)

  check_empty_beaustier_folders()
})

test_that("use, jar", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_jar_path <- get_default_beast2_jar_path()
  input_filename <- "input.xml"

  created <- create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = beast2_jar_path
  )
  expected <- c(
    get_default_java_path(),
    "-cp",
    beast2_jar_path,
    get_beast2_main_class_name(),
    "-validate",
    input_filename
  )
  expect_equal(created, expected)
  check_empty_beaustier_folders()
})

test_that("use, bin, spaces in BEAST2 bin path", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_path <- file.path(
    get_beastier_tempfilename(),
    "path with spaces",
    "beast"
  )
  expect_true(is_bin_path(beast2_path))
  dir.create(dirname(beast2_path), showWarnings = FALSE, recursive = TRUE)
  file.copy(
    from = get_default_beast2_bin_path(),
    to = beast2_path
  )

  cmd <- create_beast2_validate_cmd(
    input_filename = "irrelevant",
    beast2_path = beast2_path
  )
  # The first cmd is the file to be run. It must be findable
  expect_true(file.exists(cmd[1]))
  expect_equal(cmd[1], beast2_path)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use, bin, spaces in BEAST2 jar path", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_path <- file.path(
    get_beastier_tempfilename(),
    "path with spaces",
    "launcher.jar"
  )
  expect_true(is_jar_path(beast2_path))
  dir.create(dirname(beast2_path), showWarnings = FALSE, recursive = TRUE)
  file.copy(
    from = get_default_beast2_jar_path(),
    to = beast2_path
  )

  cmd <- create_beast2_validate_cmd(
    input_filename = "irrelevant",
    beast2_path = beast2_path
  )
  expect_false(beast2_path %in% cmd)
  expect_true(shQuote(beast2_path) %in% cmd)

  remove_beaustier_folders()
  check_empty_beaustier_folders()
})

test_that("use, bin, spaces in BEAST2 input filename", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  input_filename <- "path with spaces/input.xml"

  cmd <- create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = get_default_beast2_bin_path()
  )
  expect_false("path with spaces/input.xml" %in% cmd)
  expect_true(shQuote("path with spaces/input.xml") %in% cmd)

  check_empty_beaustier_folders()
})

test_that("use, jar, spaces in BEAST2 input filename", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  input_filename <- "path with spaces/input.xml"

  cmd <- create_beast2_validate_cmd(
    input_filename = input_filename,
    beast2_path = get_default_beast2_jar_path()
  )
  expect_false("path with spaces/input.xml" %in% cmd)
  expect_true(shQuote("path with spaces/input.xml") %in% cmd)

  check_empty_beaustier_folders()
})
