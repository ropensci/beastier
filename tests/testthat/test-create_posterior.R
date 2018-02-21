context("create_posterior")

test_that("returns a posterior", {

  if (!beastier:::is_on_travis()) return()

  posterior <- beastier:::create_posterior(
    n_taxa = 2,
    sequence_length = 4,
    mcmc = beautier::create_mcmc(chain_length = 2000)
  )
  testthat::expect_true(tracerer::is_posterior(posterior))

})

test_that("use", {

  if (!beastier:::is_on_travis()) return()

  testthat::expect_silent(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 2000)
    )
  )

  testthat::expect_silent(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = 15
    )
  )

  testthat::expect_silent(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = c(15, 15)
    )
  )

  testthat::expect_silent(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = c(10, NA)
    )
  )
})

test_that("abuse", {

  testthat::expect_error(
    beastier:::create_posterior(
      n_taxa = -1, # Must be positive
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = 15
    ),
    "'n_taxa' must be two or more"
  )

  testthat::expect_error(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 0, # Must be non-zero positive
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = 15
    ),
    "'sequence_length' must be one or more"
  )

  testthat::expect_error(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 1,
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = ape::rcoal(3) # Error
    ),
    "crown age must be either NA or a non-zero positive number"
  )

  testthat::expect_error(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 1,
      mcmc = beautier::create_mcmc(chain_length = 2000),
      crown_ages = -123 # Error
    ),
    "crown age must be either NA or a non-zero positive number"
  )

  testthat::expect_error(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 1,
      crown_ages = 15,
      mcmc = "nonsense"
    ),
    "'mcmc' must be a valid mcmc object"
  )

  testthat::expect_error(
    beastier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = -1234)
    ),
    "'chain_length' must be"
  )

})

test_that("One fixed crown age must have equal TreeHeights", {

  if (!beastier:::is_on_travis()) return()

  posterior <- beastier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 2000),
    crown_ages = 15
  )
  testthat::expect_true(all(posterior$estimates$TreeHeight
    == posterior$estimates$TreeHeight[1]))
})

test_that("Two fixed crown ages must have equal TreeHeights", {

  if (!beastier:::is_on_travis()) return()

  crown_age_1 <- 15
  crown_age_2 <- 15
  posterior <- beastier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 2000),
    crown_ages = c(crown_age_1, crown_age_2)
  )
  testit::assert("estimates" %in% names(posterior))
  testit::assert("tmp_create_posterior_1_trees" %in% names(posterior))
  testit::assert("tmp_create_posterior_2_trees" %in% names(posterior))
  testit::assert("TreeHeight.1" %in% names(posterior$estimates))
  testit::assert("TreeHeight.2" %in% names(posterior$estimates))

  n <- length(posterior$estimates$TreeHeight.1)
  testthat::expect_true(
    all.equal(posterior$estimates$TreeHeight.1, rep(crown_age_1, n))
  )

  # Unexpected: should be all of crown age
  testthat::expect_true(
    all.equal(posterior$estimates$TreeHeight.2, rep(crown_age_2, n)) != TRUE
  )
})


test_that(paste0("One fixed crown age must result in a posterior ",
  "with that TreeHeight"), {

  if (!beastier:::is_on_travis()) return()

  crown_age <- 123
  posterior <- beastier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 2000),
    crown_ages = crown_age
  )
  testthat::expect_equal(posterior$estimates$TreeHeight[1], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight[10], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(
    crown_age,
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_1_trees$STATE_2000
    ),
    tolerance = 0.001
  )
})

test_that(paste0("Two same fixed crown ages must result in a posterior ",
  "with that TreeHeight"), {

  if (!beastier:::is_on_travis()) return()

  crown_age <- 123
  posterior <- beastier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 2000),
    crown_ages = c(crown_age, crown_age)
  )
  n <- length(posterior$estimates$TreeHeight.1)

  testthat::expect_true(
    all.equal(posterior$estimates$TreeHeight.1, rep(crown_age, n))
  )

  # Unexpected: should be all of crown age
  testthat::expect_true(
    all.equal(posterior$estimates$TreeHeight.2, rep(crown_age, n)) != TRUE
  )

  testthat::expect_equal(crown_age,
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_1_trees$STATE_2000
    ),
    tolerance = 0.001
  )

  # Unexpected: second alignment's phylo does not have the
  # desired fixed crown age
  testthat::expect_true(crown_age !=
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_2_trees$STATE_2000
    )
  )
})

test_that(paste0("Two different fixed crown ages must result in a posterior ",
  "with the first crown age's TreeHeight"), {

  if (!beastier:::is_on_travis()) return()

  crown_age_1 <- 123
  crown_age_2 <- 234
  posterior <- beastier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 2000),
    crown_ages = c(crown_age_1, crown_age_2)
  )
  names(posterior)
  testthat::expect_equal(posterior$estimates$TreeHeight.1[1], crown_age_1,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight.1[10], crown_age_1,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight.2[1], crown_age_2,
    tolerance = 0.001)

  # Unexpected: will differ
  testthat::expect_true(posterior$estimates$TreeHeight.2[10] != crown_age_2)

  testthat::expect_equal(crown_age_1,
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_1_trees$STATE_2000
    ),
    tolerance = 0.001
  )

  # Unexpected: will differ
  testthat::expect_true(crown_age_2 !=
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_2_trees$STATE_2000
    )
  )

})

test_that(paste0("One fixed crown age, one estimated, ",
  "will result in a posterior with the specified TreeHeight"
), {

  if (!beastier:::is_on_travis()) return()

  crown_age <- 123
  posterior <- beastier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 2000),
    crown_ages = c(crown_age, NA)
  )
  names(posterior$estimates)
  testthat::expect_equal(posterior$estimates$TreeHeight.1[1], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight.1[10], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(crown_age,
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_1_trees$STATE_2000
    ),
    tolerance = 0.001
  )

  testthat::expect_true(crown_age !=
    beautier:::get_phylo_crown_age(
      posterior$tmp_create_posterior_2_trees$STATE_2000
    )
  )
})
