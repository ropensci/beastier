#' Find duplicate \code{RealParameter} IDs
#' @param text the XML as text
#' @return a vector of duplicate IDs, will be empty if all IDs are unique
#' @seealso to see if all IDs are unique, use \code{\link{has_unique_ids}}
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   line_1 <- "<parameter id=\"RealParameter.1\" ...</parameter>"
#'   line_2 <- "<parameter id=\"RealParameter.2\" ...</parameter>"
#'   testit::assert(
#'     length(get_duplicate_param_ids(c(line_1, line_2))) == 0)
#'   testit::assert(
#'     get_duplicate_param_ids(
#'     c(line_1, line_1)) == c("RealParameter.1")
#'   )
#'   testit::assert(
#'     get_duplicate_param_ids(
#'     c(line_2, line_2)) == c("RealParameter.2")
#'   )
#' @export
get_duplicate_param_ids <- function(
  text
) {
  if (!is.character(text)) {
    stop("'text' must be text")
  }
  matches <- text
  for (i in seq_along(matches)) {
    matches[i] <- stringr::str_extract(
      str = text[i],
      pattern = "RealParameter\\.[[:digit:]]+")
  }
  matches <- matches[!is.na(matches)]
  matches[duplicated(matches)]
}
