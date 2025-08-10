#' Determines if the two alignments are equal
#' @param p the first alignment
#' @param q the second alignment
#' @return TRUE or FALSE
#' @author Richèl J.C. Bilderbeek
#' @export
are_identical_alignments <- function(p, q) {
  if (!is_alignment(p)) {
    stop("p must be an alignment")
  }
  if (!is_alignment(q)) {
    stop("q must be an alignment")
  }
  identical(p, q)
}
