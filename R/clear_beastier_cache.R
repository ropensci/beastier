#' Clear the \link{beastier} cache
#'
#' Clear the \link{beastier} cache.
#' @inheritParams default_params_doc
#' @return Nothing.
#' @author Richèl J.C. Bilderbeek
#' @export
clear_beastier_cache <- function(
  beastier_folder = get_beastier_folder()
) {
  dirs <- list.dirs(beastier_folder, full.names = TRUE)
  unlink(dirs, recursive = TRUE)
  files <- list.files(beastier_folder, full.names = TRUE)
  file.remove(files)
}
