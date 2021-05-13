test_that("minimal use", {
  if (!is_beast2_installed()) return()

  expect_silent(
    create_beast2_run_cmd_from_options(
      beast2_options = create_beast2_options()
    )
  )
})

test_that("use, bin", {

  if (!is_beast2_installed()) return()

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
    paste0(
      "\"",
      normalizePath(beast2_options$output_state_filename, mustWork = FALSE),
      "\""
    ),
    "-overwrite",
    paste0(
      "\"",
      normalizePath(beast2_options$input_filename, mustWork = FALSE),
      "\""
    )
  )
  expect_equal(created_from_options, expected)
})

test_that("use, jar", {

  if (!is_beast2_installed()) return()

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
    paste0(
      "\"",
      normalizePath(beast2_options$output_state_filename, mustWork = FALSE),
      "\""
    ),
    "-overwrite",
    paste0(
      "\"",
      normalizePath(beast2_options$input_filename, mustWork = FALSE),
      "\""
    )
  )
  expect_equal(created_from_options, expected)
})

test_that("different overwrite option results in different command", {

  if (!is_beast2_installed()) return()

  cmd_true <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(overwrite = TRUE)
  )
  cmd_false <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(overwrite = FALSE)
  )
  expect_true(length(cmd_false) != length(cmd_true))
})

test_that("different use_beagle option results in different command", {

  if (!is_beast2_installed()) return()

  cmd_true <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(use_beagle = TRUE)
  )
  cmd_false <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(use_beagle = FALSE)
  )
  expect_true(length(cmd_false) != length(cmd_true))
})

test_that("different n_threads option results in different command", {

  if (!is_beast2_installed()) return()

  cmd_true <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(n_threads = 2)
  )
  cmd_false <- beastier::create_beast2_run_cmd_from_options(
    create_beast2_options(n_threads = 3)
  )
  expect_false(all(cmd_false == cmd_true))
})
