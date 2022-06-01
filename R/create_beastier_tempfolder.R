#' Create the temporary folder as used by \link{beastier}
#' @return nothing
#' @examples
#' check_empty_beaustier_folders()
#'
#' create_beastier_tempfolder()
#'
#' remove_beaustier_folders()
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beastier_tempfolder <- function() {
  dir.create(
    dirname(beastier::get_beastier_tempfilename()),
    showWarnings = FALSE,
    recursive = TRUE
  )
}
