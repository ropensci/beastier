#' Determines if the input is an alignment of type DNAbin
#' @param input The input to be testes
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
is_alignment <- function(input) {
  return(class(input) == "DNAbin")
}
