context("create_random_fastas")

test_that("use", {

  fasta_filenames <- c(tempfile(fileext = ".fas"), tempfile(fileext = ".fas"))
  testit::assert(length(fasta_filenames) == 2)
  expect_silent(
    beastier:::create_random_fastas(
      n_taxa = 5,
      sequence_length = 20,
      fasta_filenames = fasta_filenames
    )
  )
  testthat::expect_true(all(file.exists(fasta_filenames)))
})
