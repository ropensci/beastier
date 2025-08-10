#' Check there are no files in the default \link[beautier]{beautier} folder
#'
#' Check there are no files in the default \link[beautier]{beautier} folder.
#' The goal is to make sure no temporary files are left undeleted.
#' Will \link{stop} if there are files in the \link[beautier]{beautier} folder.
#'
#' @seealso use \link[beautier]{remove_beautier_folder} to remove the default
#' `beautier` folder
#' @return Nothing.
#' @examples
#' check_empty_beastier_folder()
#'
#' remove_beastier_folder()
#'
#' check_empty_beastier_folder()
#' @author Richèl J.C. Bilderbeek
#' @export
remove_beastier_folder <- function() {
  folder_name <- beastier::get_beastier_folder()
  if (dir.exists(folder_name)) {
    unlink(folder_name, recursive = TRUE)
  }
}
