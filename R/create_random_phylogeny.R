#' Create a random phylogeny
#' @inheritParams default_params_doc
#' @param taxa_name_ext the extension of the taxa names
#' @return a phylogeny of class \code{phylo}
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   n_taxa <- 6
#'   phylogeny <- create_random_phylogeny(n_taxa = n_taxa)
#'
#'   expect_equal(n_taxa, ape::Ntip(phylogeny))
#'   expect_equal("phylo", class(phylogeny))
#' @noRd
create_random_phylogeny <- function(
  n_taxa,
  taxa_name_ext = ""
) {
  phylogeny <- ape::rcoal(n = n_taxa)
  phylogeny$tip.label <- paste0(phylogeny$tip.label, taxa_name_ext) # nolint APE uses a different style guideline
  phylogeny
}
