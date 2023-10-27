#' Determine if the XML text has unique parameter IDs
#' @param text the XML as text
#' @return TRUE if all parameter IDs are unique, FALSE otherwise
#' @seealso to obtain the duplicate parameter IDs, use
#'   \code{\link{get_duplicate_param_ids}}
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' line_1 <- "<parameter id=\"RealParameter.1\" ...</parameter>"
#' line_2 <- "<parameter id=\"RealParameter.2\" ...</parameter>"
#' # Unique IDs
#' has_unique_ids(c(line_1, line_2))
#' # No unique ID
#' has_unique_ids(c(line_1, line_1))
#'
#' check_empty_beaustier_folders()
#' @export
has_unique_ids <- function(
  text
) {
  length(get_duplicate_param_ids(text)) == 0
}
