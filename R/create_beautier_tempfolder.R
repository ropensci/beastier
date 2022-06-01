#' Create the default `beautier` temporary folder
#' @return nothing
#' @examples
#' check_empty_beaustier_folders()
#'
#' create_beautier_tempfolder()
#'
#' remove_beaustier_folders()
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beautier_tempfolder <- function() {
  dir.create(
    dirname(beautier::get_beautier_tempfilename()),
    showWarnings = FALSE,
    recursive = TRUE
  )
}
