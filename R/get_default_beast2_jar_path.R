#' Get the default BEAST2 jar file's path
#' @seealso Use \link{get_default_beast2_folder} to get the default
#'   folder in which BEAST2 is installed
#' @examples
#'   testit::assert(get_default_beast2_jar_path()
#'     == "~/Programs/beast/lib/beast.jar")
#' @author Richel J.C. Bilderbeek
#' @export
get_default_beast2_jar_path <- function() {
  paste0(get_default_beast2_folder(), "/lib/beast.jar")
}
