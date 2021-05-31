test_that("use", {
  filename <- get_beastier_tempfilename()
  expect_silent(
    create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = filename
    )
  )
  expect_true(file.exists(filename))
  file.remove(filename)
})

test_that("sub-sub folder", {
  filename <- file.path(get_beastier_tempfilename(), "sub", "sub", "sub")
  expect_silent(
    create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = filename
    )
  )
  expect_true(file.exists(filename))
  file.remove(filename)
  unlink(dirname(dirname(dirname(filename))), recursive = TRUE)
})

test_that("abuse", {
  expect_error(
    create_random_fasta(
      n_taxa = 0, #Error
      sequence_length = 20,
      fasta_filename = "test.fasta"
    ),
    "'n_taxa' must two or more"
  )

  expect_error(
    create_random_fasta(
      n_taxa = 5,
      sequence_length = 0, # Error
      fasta_filename = "test.fasta"
    ),
    "'sequence_length' must be one or more"
  )

  expect_error(
    create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = ape::rcoal(4)
    ),
    "'fasta_filename' must be a character string"
  )

  expect_error(
    create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = "" # Error
    ),
    "'fasta_filename' must have at least one character"
  )

  expect_error(
    create_random_fasta(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filename = "test.fasta",
      taxa_name_ext = ape::rcoal(3) # Error
    ),
    "'taxa_name_ext' must be a character string"
  )
})
