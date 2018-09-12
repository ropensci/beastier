#' Get the default BEAST2 binary file (\code{beast}, that is) path
#' @return the default BEAST2 binary file's path
#' @seealso Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed.
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this location.
#' @examples
#'   if (rappdirs::app_dir()$os == "unix") {
#'     testit::assert(
#'       grepl(
#'         "/home/[A-Za-z0-9_]*/.local/share/beast/bin/beast",
#'         get_default_beast2_bin_path()
#'       )
#'     )
#'   }
#' @author Richel J.C. Bilderbeek
#' @export
get_default_beast2_bin_path <- function() {
  normalizePath(file.path(get_default_beast2_folder(), "beast", "bin", "beast")) # nolint internal function
}
