test_that("minimal use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  expect_silent(
    create_beast2_run_cmd_from_options(
      beast2_options = create_beast2_options()
    )
  )

  check_empty_beaustier_folders()
})

test_that("use, bin", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_options <- create_beast2_options(
    overwrite = TRUE,
    beast2_path = get_default_beast2_bin_path()
  )
  created_from_options <- beastier::create_beast2_run_cmd_from_options(
    beast2_options = beast2_options
  )
  expected <- c(
    beast2_options$beast2_path,
    "-statefile",
    beast2_options$output_state_filename,
    "-overwrite",
    beast2_options$input_filename
  )
  expect_equal(created_from_options, expected)

  check_empty_beaustier_folders()
})

test_that("use, jar", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  beast2_options <- create_beast2_options(
    overwrite = TRUE,
    beast2_path = get_default_beast2_jar_path()
  )
  created_from_options <- create_beast2_run_cmd_from_options(
    beast2_options = beast2_options
  )
  expected <- c(
    get_default_java_path(),
    "-cp",
    beast2_options$beast2_path,
    get_beast2_main_class_name(),
    "-statefile",
    beast2_options$output_state_filename,
    "-overwrite",
    beast2_options$input_filename
  )
  expect_equal(created_from_options, expected)

  check_empty_beaustier_folders()

})

test_that("different overwrite option results in different command", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  cmd_true <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(overwrite = TRUE)
  )
  cmd_false <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(overwrite = FALSE)
  )
  expect_true(length(cmd_false) != length(cmd_true))

  check_empty_beaustier_folders()

})

test_that("different use_beagle option results in different command", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  cmd_true <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(use_beagle = TRUE)
  )
  cmd_false <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(use_beagle = FALSE)
  )
  expect_true(length(cmd_false) != length(cmd_true))
  check_empty_beaustier_folders()
})

test_that("different n_threads option results in different command", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  check_empty_beaustier_folders()

  cmd_true <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(n_threads = 2)
  )
  cmd_false <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(n_threads = 3)
  )
  expect_false(all(cmd_false == cmd_true))
  check_empty_beaustier_folders()
})
