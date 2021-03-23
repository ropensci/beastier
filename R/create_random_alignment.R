#' Create a random alignment
#' @inheritParams default_params_doc
#' @param sequence_length The number of base pairs the alignment will have
#' @param rate mutation rate
#' @param taxa_name_ext the extension of the taxa names
#' @return an alignment of class \link[ape]{DNAbin}
#' @author Richèl J.C. Bilderbeek
#' @examples
#'  alignment <- create_random_alignment(
#'    n_taxa = 5,
#'    sequence_length = 10
#'  )
#'  image(alignment)
#' @export
create_random_alignment <- function(
  n_taxa,
  sequence_length,
  rate = 1,
  taxa_name_ext = ""
) {
  if (n_taxa < 2) {
    stop("need n_taxa >= 2")
  }
  if (sequence_length < 1) {
    stop("need sequence_length >= 1")
  }
  if (rate < 0.0 || rate > 1.0) {
    stop("rate needs to be [0.0, 1.0]")
  }

  phylogeny <- beastier::create_random_phylogeny(
    n_taxa = n_taxa,
    taxa_name_ext = taxa_name_ext
  )

  alignments_phydat <- phangorn::simSeq(
    phylogeny, l = sequence_length, rate = rate
  )
  alignments_dnabin <- ape::as.DNAbin(alignments_phydat)
  alignments_dnabin
}
