#' Get the path to the folder where this package installs
#' BEAST2 by default
#' @return the path to the folder where this package installs
#'   BEAST2 by default
#' @author Richèl J.C. Bilderbeek
#' @seealso Use \link{get_default_beast2_jar_path} to get the path
#'   to the BEAST2 jar file, when installed by this package
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this folder.
#' @export
#' @examples
#'   if (rappdirs::app_dir()$os == "unix") {
#'     testit::assert(
#'       grepl(
#'         "/home/[A-Za-z0-9_]*/.local/share",
#'         get_default_beast2_folder()
#'       )
#'     )
#'   }
get_default_beast2_folder <- function() {
  rappdirs::user_data_dir()
}
