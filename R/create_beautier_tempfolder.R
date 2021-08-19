#' Create the temporary folder as used by \link[beautier]{beautier}
#' @return nothing
#' @examples
#' create_beautier_tempfolder()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beautier_tempfolder <- function() {
  dir.create(
    dirname(beautier::get_beautier_tempfilename()),
    showWarnings = FALSE,
    recursive = TRUE
  )
}
