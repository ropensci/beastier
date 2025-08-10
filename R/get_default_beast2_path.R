#' Get the default BEAST2 path
#' @inheritParams default_params_doc
#' @return the default BEAST2 path
#' @seealso
#'   Use \link{get_default_beast2_bin_path}
#'     to get the default path to the BEAST2 binary file.
#'   Use \link{get_default_beast2_jar_path}
#'     to get the default path to the BEAST2 jar file.
#'   Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed.
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this location.
#' @examples
#' if (is_beast2_installed()) {
#'   get_default_beast2_path()
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
get_default_beast2_path <- function(
  beast2_folder = beastier::get_default_beast2_folder(),
  os = rappdirs::app_dir()$os
) {
  beastier::get_default_beast2_jar_path(
    beast2_folder = beast2_folder,
    os = os
  )
}
