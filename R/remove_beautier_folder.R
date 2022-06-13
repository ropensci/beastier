#' Deprecated function, use \link[beautier]{remove_beautier_folder}.
#'
#' Deprecated function, use \link[beautier]{remove_beautier_folder}.
#'
#' Check there are no files in the default `beautier` folder.
#' The goal is to make sure no temporary files are left undeleted.
#' Will \link{stop} if there are files in the `beautier` folder.
#'
#' @return Nothing.
#' @author Richèl J.C. Bilderbeek
#' @export
remove_beautier_folder <- function() {
  stop(
    "'beastier::remove_beautier_folder' is deprecated, ",
    "use 'beautier::remove_beautier_folder' instead"
  )
}
