context("create_posterior")

test_that("returns a posterior", {

  if (!lumier:::is_on_travis()) return()

  posterior <- lumier:::create_posterior(
    n_taxa = 2,
    sequence_length = 4,
    mcmc = beautier::create_mcmc(chain_length = 10000)
  )
  testthat::expect_true(beastier::is_posterior(posterior))

})

test_that("use", {

  if (!lumier:::is_on_travis()) return()

  testthat::expect_silent(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 10000)
    )
  )

  testthat::expect_silent(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = 15
    )
  )

  testthat::expect_silent(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = c(15, 15)
    )
  )

  testthat::expect_silent(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = c(10, NA)
    )
  )
})

test_that("abuse", {

  testthat::expect_error(
    lumier:::create_posterior(
      n_taxa = -1, # Must be positive
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = 15
    ),
    "'n_taxa' must be two or more"
  )

  testthat::expect_error(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 0, # Must be non-zero positive
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = 15
    ),
    "'sequence_length' must be one or more"
  )

  testthat::expect_error(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 1,
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = ape::rcoal(3) # Error
    ),
    "crown age must be either NA or a non-zero positive number"
  )

  testthat::expect_error(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 1,
      mcmc = beautier::create_mcmc(chain_length = 10000),
      crown_ages = -123 # Error
    ),
    "crown age must be either NA or a non-zero positive number"
  )

  testthat::expect_error(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 1,
      crown_ages = 15,
      mcmc = "nonsense"
    ),
    "'mcmc' must be a valid mcmc object"
  )

  testthat::expect_error(
    lumier:::create_posterior(
      n_taxa = 2,
      sequence_length = 4,
      mcmc = beautier::create_mcmc(chain_length = -1234)
    ),
    "chain_length must be at least"
  )

})

test_that("One fixed crown age must have equal TreeHeights", {

  if (!lumier:::is_on_travis()) return()

  posterior <- lumier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 10000),
    crown_ages = 15
  )
  testthat::expect_true(all(posterior$estimates$TreeHeight
    == posterior$estimates$TreeHeight[1]))
})

test_that("Two fixed crown ages must have equal TreeHeights", {

  if (!lumier:::is_on_travis()) return()

  posterior <- lumier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 10000),
    crown_ages = c(15, 15)
  )
  testthat::expect_true(all(posterior$estimates$TreeHeight
    == posterior$estimates$TreeHeight[1]))
})


test_that(paste0("One fixed crown age must result in a posterior ",
  "with that TreeHeight"), {

  if (!lumier:::is_on_travis()) return()

  crown_age <- 123
  posterior <- lumier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 10000),
    crown_ages = crown_age
  )
  testthat::expect_equal(posterior$estimates$TreeHeight[1], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight[10], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(crown_age,
    beautier:::get_phylo_crown_age(posterior$trees$STATE_10000),
    tolerance = 0.001)
})

test_that(paste0("Two same fixed crown ages must result in a posterior ",
  "with that TreeHeight"), {

  if (!lumier:::is_on_travis()) return()

  crown_age <- 123
  posterior <- lumier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 10000),
    crown_ages = c(crown_age, crown_age)
  )
  testthat::expect_equal(posterior$estimates$TreeHeight[1], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight[10], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(crown_age,
    beautier:::get_phylo_crown_age(posterior$trees$STATE_10000),
    tolerance = 0.001)
})

test_that(paste0("Two different fixed crown ages must result in a posterior ",
  "with the first crown age's TreeHeight"), {

  if (!lumier:::is_on_travis()) return()

  crown_age_1 <- 123
  crown_age_2 <- 234
  posterior <- lumier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 10000),
    crown_ages = c(crown_age_1, crown_age_2)
  )
  testthat::expect_equal(posterior$estimates$TreeHeight[1], crown_age_1,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight[10], crown_age_1,
    tolerance = 0.001)
  testthat::expect_equal(crown_age_1,
    beautier:::get_phylo_crown_age(posterior$trees$STATE_10000),
    tolerance = 0.001)
})

test_that(paste0("One fixed crown age, one estimated, ",
  "will result in a posterior with the specified TreeHeight"
), {

  if (!lumier:::is_on_travis()) return()

  crown_age <- 123
  posterior <- lumier:::create_posterior(
    n_taxa = 5,
    sequence_length = 10,
    mcmc = beautier::create_mcmc(chain_length = 10000),
    crown_ages = c(crown_age, NA)
  )
  testthat::expect_equal(posterior$estimates$TreeHeight[1], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(posterior$estimates$TreeHeight[10], crown_age,
    tolerance = 0.001)
  testthat::expect_equal(crown_age,
    beautier:::get_phylo_crown_age(posterior$trees$STATE_10000),
    tolerance = 0.001)
})
