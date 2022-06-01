#' Check there are no files in the default `beautier` folder
#'
#' Check there are no files in the default `beautier` folder.
#' The goal is to make sure no temporary files are left undeleted.
#' Will \link{stop} if there are files in the `beautier` folder.
#'
#' @return Nothing.
#' @examples
#' remove_beautier_folder()
#' @author Richèl J.C. Bilderbeek
#' @export
remove_beautier_folder <- function() {
  folder_name <- beautier::get_beautier_folder()
  if (dir.exists(folder_name)) {
    unlink(folder_name, recursive = TRUE)
  }
}
