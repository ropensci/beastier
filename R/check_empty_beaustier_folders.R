#' Check there are no files in the default
#' `beautier` and `beastier` folders
#'
#' Check there are no files in the default
#' `beautier` and `beastier` folders.
#'
#' The goal is to make sure no temporary files are left undeleted.
#' Will \link{stop} if there are files in the \link[beautier]{beautier}
#' of \link{beastier} folder.
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if there are files in the \link[beautier]{beautier}
#' of \link{beastier} folder.
#' @author Richèl J.C. Bilderbeek
#' @export
check_empty_beaustier_folders <- function(
  beautier_folder = beautier::get_beautier_folder(),
  beastier_folder = get_beastier_folder()
) {
  check_empty_beastier_folder(beastier_folder = beastier_folder)
  beautier::check_empty_beautier_folder(beautier_folder = beautier_folder)
}
