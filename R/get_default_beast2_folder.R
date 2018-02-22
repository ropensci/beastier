#' Get the path to the folder where this package installs
#' BEAST2 by default
#' @author Richel J.C. Bilderbeek
#' @seealso Use \link{get_default_beast2_jar_path} to get the path
#'   to the BEAST2 jar file, when installed by this package
#' @export
#' @examples
#'   testit::assert(get_default_beast2_folder() == "~/Programs/beast")
get_default_beast2_folder <- function() {
  "~/Programs/beast"
}
