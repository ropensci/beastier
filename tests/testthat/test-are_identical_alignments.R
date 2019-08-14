context("are_identical_alignments")

test_that("are_identical_alignments: use", {

  p <- create_random_alignment(
    n_taxa = 5,
    sequence_length = 10
  )
  q <- create_random_alignment(
    n_taxa = 5,
    sequence_length = 10
  )
  expect_true(are_identical_alignments(p, p))
  expect_true(are_identical_alignments(q, q))
  expect_false(are_identical_alignments(p, q))
})

test_that("are_identical_alignments: abuse", {

  p <- create_random_alignment(
    n_taxa = 5,
    sequence_length = 10
  )
  expect_error(
    are_identical_alignments("Not a phylogeny", p),
    "p must be an alignment"
  )
  expect_error(
    are_identical_alignments(p, "Not a phylogeny"),
    "q must be an alignment"
  )
})
