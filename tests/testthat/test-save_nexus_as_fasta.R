test_that("use", {
  expect_equal(1 + 1, 2) # nolint to prevent 'Reason: empty test'
  if (!is_beast2_installed()) return()

  nexus_filename <- get_beast2_example_filename("Primates.nex")
  fasta_filename <- get_beastier_tempfilename()
  save_nexus_as_fasta(
    nexus_filename = nexus_filename,
    fasta_filename = fasta_filename
  )
  expect_true(file.exists(fasta_filename))
  expect_silent(ape::read.FASTA(fasta_filename))
  file.remove(fasta_filename)
})
