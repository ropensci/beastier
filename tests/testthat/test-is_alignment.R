context("is_alignment")

test_that("is_alignment: use", {
  alignment_a <- beastier:::create_random_alignment(
    n_taxa = 5,
    sequence_length = 10
  )
  alignment_b <- beastier:::create_random_alignment(
    n_taxa = 2,
    sequence_length = 1
  )
  expect_true(is_alignment(alignment_a))
  expect_true(is_alignment(alignment_b))
  expect_true(!is_alignment(list(alignment_a, alignment_a)))
  expect_true(!is_alignment(ape::rmtree(N = 2, n = 10)))
  expect_true(!is_alignment(42))
  expect_true(!is_alignment(3.14))
  expect_true(!is_alignment("Hello"))
  expect_true(!is_alignment(NULL))
  expect_true(!is_alignment(NA))
  expect_true(!is_alignment(Inf))
})
