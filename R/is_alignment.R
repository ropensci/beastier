#' Determines if the input is an alignment of type \link[ape]{DNAbin}
#' @param input The input to be tested
#' @return TRUE or FALSE
#' @author Richèl J.C. Bilderbeek
#' @export
is_alignment <- function(input) {
  class(input) == "DNAbin"
}
