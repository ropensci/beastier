context("test-check_beast2_options")

test_that("use", {
  expect_silent(check_beast2_options(create_beast2_options()))

  # 'rng_seed' can be both NA and a value
  expect_silent(
    check_beast2_options(
      create_beast2_options(
        rng_seed = NA
      )
    )
  )
    expect_silent(
      check_beast2_options(
        create_beast2_options(
          rng_seed = 1
      )
    )
  )

  # 'n_threads' can be both NA and a value
    expect_silent(
      check_beast2_options(
        create_beast2_options(
          n_threads = NA
      )
    )
  )
  expect_silent(
    check_beast2_options(
      create_beast2_options(
        n_threads = 1
      )
    )
  )

  # Must stop on nonsense
  expect_error(check_beast2_options(beast2_options = "nonsense"))
  expect_error(check_beast2_options(beast2_options = NULL))
  expect_error(check_beast2_options(beast2_options = NA))
})

test_that("in-depth use", {

  good_beast2_options <- create_beast2_options()
  expect_silent(check_beast2_options(good_beast2_options))

  # Wrong parameter names
  beast2_options <- good_beast2_options
  beast2_options$output_log_filename <- NULL
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'output_log_filename' must be an element of an 'beast2_options'"
  )

  beast2_options <- good_beast2_options
  beast2_options$output_trees_filenames <- NULL
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'output_trees_filenames' must be an element of an 'beast2_options'"
  )

  beast2_options <- good_beast2_options
  beast2_options$rng_seed <- NULL
  expect_error(
    check_beast2_options(beast2_options),
    "'rng_seed' must be an element of an 'beast2_options'"
  )

  beast2_options <- good_beast2_options
  beast2_options$n_threads <- NULL
  expect_error(
    check_beast2_options(beast2_options),
    "'n_threads' must be an element of an 'beast2_options'"
  )

  beast2_options <- good_beast2_options
  beast2_options$use_beagle <- NULL
  expect_error(
    check_beast2_options(beast2_options),
    "'use_beagle' must be an element of an 'beast2_options'"
  )

  beast2_options <- good_beast2_options
  beast2_options$overwrite <- NULL
  expect_error(
    check_beast2_options(beast2_options),
    "'overwrite' must be an element of an 'beast2_options'"
  )
  beast2_options <- good_beast2_options
  beast2_options$beast2_path <- NULL
  expect_error(
    check_beast2_options(beast2_options),
    "'beast2_path' must be an element of an 'beast2_options'"
  )
  beast2_options <- good_beast2_options
  beast2_options$verbose <- NULL
  expect_error(
    check_beast2_options(beast2_options),
    "'verbose' must be an element of an 'beast2_options'"
  )


  ##############################################################################
  # Wrong parameter values
  ##############################################################################
  # output_log_filename
  expect_error(
    check_beast2_options(
      create_beast2_options(output_log_filename = NULL)
    ),
    "'output_log_filename' must be one character string"
  )

  # output_trees_filenames
  expect_error(
    check_beast2_options(
      create_beast2_options(output_trees_filenames = NULL)
    ),
    "'output_trees_filenames' must be one character string"
  )

  # output_state_filename
  expect_error(
    check_beast2_options(
      create_beast2_options(output_state_filename = NULL)
    ),
    "'output_state_filename' must be one character string"
  )

  # rng_seed
  expect_error(
    check_beast2_options(
      create_beast2_options(rng_seed = "nonsense")
    ),
    "'rng_seed' should be one NA or one non-zero positive value"
  )

  # n_threads
  expect_error(
    check_beast2_options(
      create_beast2_options(n_threads = "nonsense")
    ),
    "'n_threads' should be one NA or one non-zero positive value"
  )

  # use_beagle
  expect_error(
    check_beast2_options(
      create_beast2_options(use_beagle = "nonsense")
    ),
    "'use_beagle' must be one boolean"
  )

  # overwrite
  expect_error(
    check_beast2_options(
      create_beast2_options(overwrite = "nonsense")
    ),
    "'overwrite' must be one boolean"
  )

  # beast2_path
  expect_error(
    check_beast2_options(
      create_beast2_options(beast2_path = NULL)
    ),
    "'beast2_path' must be one character string"
  )

  # verbose
  expect_error(
    check_beast2_options(
      create_beast2_options(verbose = "nonsense")
    ),
    "'verbose' must be one boolean"
  )

  ##############################################################################
  # Duplicate filenames
  ##############################################################################

  # 1: input
  # 2: output log
  # 3: output trees
  # 4: output state
  #
  # Files to set equal:
  # 1 - 2
  # 1 - 3
  # 1 - 4
  # 2 - 3
  # 2 - 4
  # 3 - 4

  # 1 - 2
  beast2_options <- good_beast2_options
  beast2_options$input_filename <- beast2_options$output_log_filename
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'input_filename' and 'output_log_filename' must differ"
  )

  # 1 - 3
  beast2_options <- good_beast2_options
  beast2_options$input_filename <- beast2_options$output_trees_filenames
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'input_filename' and 'output_trees_filenames' must differ"
  )

  # 1 - 4
  beast2_options <- good_beast2_options
  beast2_options$input_filename <- beast2_options$output_state_filename
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'input_filename' and 'output_state_filename' must differ"
  )

  # 2 - 3
  beast2_options <- good_beast2_options
  beast2_options$output_log_filename <- beast2_options$output_trees_filenames
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'output_log_filename' and 'output_trees_filenames' must differ"
  )
  # 2 - 4
  beast2_options <- good_beast2_options
  beast2_options$output_log_filename <- beast2_options$output_state_filename
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'output_log_filename' and 'output_state_filename' must differ"
  )

  # 3 - 4
  beast2_options <- good_beast2_options
  beast2_options$output_trees_filenames <- beast2_options$output_state_filename
  expect_error(
    check_beast2_options(
      beast2_options
    ),
    "'output_trees_filenames' and 'output_state_filename' must differ"
  )

})
