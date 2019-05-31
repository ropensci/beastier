#' Get the path to the folder where this package installs
#' BEAST2 by default
#' @return the path to the folder where this package installs
#'   BEAST2 by default
#' @seealso Use \link{get_default_beast2_jar_path} to get the path
#'   to the BEAST2 jar file, when installed by this package
#'   Use \link{install_beast2} with default arguments
#'   to install BEAST2 to this folder.
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   print(get_default_beast2_folder())
#' @export
get_default_beast2_folder <- function() {
  rappdirs::user_data_dir()
}
