#' Create the temporary folder as used by \link{beastier}
#' @return nothing
#' @examples
#' create_beastier_tempfolder()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beastier_tempfolder <- function() {
  dir.create(
    dirname(beastier::get_beastier_tempfilename()),
    showWarnings = FALSE,
    recursive = TRUE
  )
}
