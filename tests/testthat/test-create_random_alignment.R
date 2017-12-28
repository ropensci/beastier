context("create_random_alignment")

test_that("use", {

  testthat::expect_silent(
    lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 20,
      rate = 0.1
    )
  )

  testthat::expect_silent(
    lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 20,
      rate = 0.1,
      taxa_name_ext = "_aco"
    )
  )

})

test_that("checks input", {

  testthat::expect_silent(
    lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 20,
      rate = 0.1
    )
  )

  testthat::expect_error(
    lumier:::create_random_alignment(
      n_taxa = 0, #Error
      sequence_length = 20,
      rate = 0.1
    )
  )

  testthat::expect_error(
    lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 0, # Error
      rate = 0.1
    )
  )

  testthat::expect_error(
    lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 20,
      rate = -0.1 #Error
    )
  )

  testthat::expect_error(
    lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 20,
      rate = 1.1 # Error
    )
  )

  result <- lumier:::create_random_alignment(
      n_taxa = 5,
      sequence_length = 20,
      rate = 0.1
    )
  testthat::expect_equal(class(result), "DNAbin")
})
