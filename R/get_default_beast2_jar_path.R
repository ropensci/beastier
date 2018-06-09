#' Get the default BEAST2 jar file's path
#' @return the default BEAST2 jar file's path
#' @seealso Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed
#' @examples
#'   if (rappdirs::app_dir()$os == "unix") {
#'     testit::assert(
#'       grepl(
#'         "/home/[A-Za-z0-9_]*/.local/share/beast/lib/beast.jar",
#'         get_default_beast2_jar_path()
#'       )
#'     )
#'   }
#' @author Richel J.C. Bilderbeek
#' @export
get_default_beast2_jar_path <- function() {
  normalizePath(file.path(get_default_beast2_folder(), "beast", "lib", "beast.jar")) # nolint internal function
}
