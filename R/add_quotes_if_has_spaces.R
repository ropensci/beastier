#' Add quotes around the string if it contains spaces.
#'
#' Add quotes around the string if it contains spaces.
#' Does nothing if the string contains no spaces.
#' This is used for filenames
#' @param filename a filename
#' @return a filename. If the filename did not contain spaces,
#' it is returned as-is. If the filename did contain spaces,
#' the filename is surrounded by quotes
#' @author Richèl J.C. Bilderbeek
#' @examples
#' add_quotes_if_has_spaces("x")
#' add_quotes_if_has_spaces("a b")
#' @export
add_quotes_if_has_spaces <- function(filename) {
  if (!is.character(filename)) {
    stop("'filename' must be a string")
  }
  if (length(filename) != 1) {
    stop("'filename' must be one string")
  }
  if (stringr::str_detect(filename, pattern = " ")) {
    filename <- shQuote(filename)
  }
  filename
}
