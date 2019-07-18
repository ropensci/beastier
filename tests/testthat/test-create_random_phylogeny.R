context("create_random_phylogeny")

test_that("use", {

  expect_silent(
    beastier:::create_random_phylogeny(n_taxa = 4)
  )

  expect_silent(
    beastier:::create_random_phylogeny(n_taxa = 4, taxa_name_ext = "_aco")
  )
})

test_that("taxon names, no taxon name extension", {

  taxon_names <- beastier:::create_random_phylogeny(n_taxa = 4)$tip.label
  expect_equal(sort(taxon_names), paste0("t", seq(1, 4)))

})

test_that("taxon names, taxon name extension", {

  ext <- "_aco"
  taxon_names <- beastier:::create_random_phylogeny(
    n_taxa = 4,
    taxa_name_ext = ext
  )$tip.label

  expect_equal(sort(taxon_names), paste0("t", seq(1, 4), ext))

})
