#' Get the path to the \link{beastier} temporary files folder
#'
#' Get the path to the \link{beastier} temporary files folder.
#' @return the path to the \link{beastier} temporary files folder.
#' @examples
#' get_beastier_folder()
#' @author Richèl J.C. Bilderbeek
#' @export
get_beastier_folder <- function(
) {
  rappdirs::user_cache_dir(appname = "beastier")
}
