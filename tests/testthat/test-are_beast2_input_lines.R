test_that("use, fast", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  expect_true(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml"))
    )
  )

  expect_true(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml")),
      method = "fast"
    )
  )

})

test_that("use, deep", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  expect_true(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml")),
      method = "deep",
      beast2_path = get_default_beast2_path()
    )
  )
})

test_that("abuse", {

  expect_error(
    are_beast2_input_lines(
      readLines(get_beastier_path("anthus_2_4.xml")),
      method = "nonsense"
    ),
    "'method' must be \"deep\" or \"fast\""
  )
})

test_that("clockRate.c ID and ClockPrior.c ID added twice", {

  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()


  # From https://github.com/ropensci/beautier/issues/127
  # From https://github.com/ropensci/beautier/issues/128

  # clock_model
  clock_rate <- 0.0000001
  clock_model <- create_strict_clock_model(
    clock_rate_param = create_clock_rate_param(value = clock_rate),
    clock_rate_distr = create_log_normal_distr(
      value = clock_rate,
      m = 1,
      s = 1.25
    )
  )

  # MRCA PRIOR
  mrca_prior <- create_mrca_prior(
    is_monophyletic = TRUE,
    mrca_distr = create_laplace_distr(mu = 1990)
  )


  inference_model <- create_inference_model(
    clock_model = clock_model,
    mrca_prior = mrca_prior,
    tipdates_filename = beautier::get_beautier_path(
      "THAILAND_TEST.clust_1.dated.txt"
    )
  )

  text <- create_beast2_input_from_model(
    input_filename = beautier::get_beautier_path(
      "THAILAND_TEST.clust_1.dated.fa"
    ),
    inference_model = inference_model
  )
  expect_true(are_beast2_input_lines(text))
})
