#' Get the default BEAST2 path
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
#'   def_path <- get_default_beast2_path()
#'   bin_path <- get_default_beast2_bin_path()
#'   jar_path <- get_default_beast2_jar_path()
#'   testthat::expect_true(def_path == bin_path || def_path == jar_path)
#' @author Richel J.C. Bilderbeek
#' @export
get_default_beast2_path <- function() {
  beastier::get_default_beast2_jar_path()
}
