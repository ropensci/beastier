context("create_random_fasta")

test_that("create_random_fasta: use", {
  filename <- tempfile()
  expect_silent(
    sequences_table <- beastier:::create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = filename
    )
  )
  expect_true(file.exists(filename))
})

test_that("create_random_fasta: abuse", {

  expect_error(
    beastier:::create_random_fasta(
      n_taxa = 0, #Error
      sequence_length = 20,
      fasta_filename = "test.fasta"
    ),
    "'n_taxa' must two or more"
  )

  expect_error(
    beastier:::create_random_fasta(
      n_taxa = 5,
      sequence_length = 0, # Error
      fasta_filename = "test.fasta"
    ),
    "'sequence_length' must be one or more"
  )

  expect_error(
    beastier:::create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = ape::rcoal(4)
    ),
    "'fasta_filename' must be a character string"
  )

  expect_error(
    beastier:::create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = "" # Error
    ),
    "'fasta_filename' must have at least one character"
  )

  expect_error(
    beastier:::create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = "test.fasta",
      taxa_name_ext = ape::rcoal(3) # Error
    ),
    "'taxa_name_ext' must be a character string"
  )

})
