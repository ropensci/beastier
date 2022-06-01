test_that("use", {
  check_empty_beaustier_folders()

  expect_silent(
    create_random_phylogeny(n_taxa = 4)
  )

  expect_silent(
    create_random_phylogeny(n_taxa = 4, taxa_name_ext = "_aco")
  )

  check_empty_beaustier_folders()

})

test_that("taxon names, no taxon name extension", {
  check_empty_beaustier_folders()

  taxon_names <- create_random_phylogeny(n_taxa = 4)$tip.label
  expect_equal(sort(taxon_names), paste0("t", seq(1, 4)))

  check_empty_beaustier_folders()

})

test_that("taxon names, taxon name extension", {
  check_empty_beaustier_folders()

  ext <- "_aco"
  taxon_names <- create_random_phylogeny(
    n_taxa = 4,
    taxa_name_ext = ext
  )$tip.label

  expect_equal(sort(taxon_names), paste0("t", seq(1, 4), ext))

  check_empty_beaustier_folders()
})
