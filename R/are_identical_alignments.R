#' Determines if the two alignments are equal
#' @param p the first alignment
#' @param q the second alignment
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
are_identical_alignments <- function(p, q) {
  if (!ribir::is_alignment(p)) {
    stop("p must be an alignment")
  }
  if (!ribir::is_alignment(q)) {
    stop("q must be an alignment")
  }
  return(identical(p, q))
}
