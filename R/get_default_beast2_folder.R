#' Get the path to the folder where this package installs
#' BEAST2 by default
#' @author Richel J.C. Bilderbeek
#' @seealso Use \link{get_default_beast2_jar_path} to get the path
#'   to the BEAST2 jar file, when installed by this package
#' @export
#' @examples
#'   if (rappdirs::app_dir()$os == "unix") {
#'     testit::assert(
#'       grepl(
#'         "/home/[A-Za-z0-9_]*/.local/share/beast",
#'         get_default_beast2_folder()
#'       )
#'     )
#'   }
get_default_beast2_folder <- function() {
  rappdirs::user_data_dir()
}
