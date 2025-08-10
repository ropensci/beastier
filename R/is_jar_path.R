#' Is the path a path to the BEAST2 jar file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 jar file
#' @author Richèl J.C. Bilderbeek
#' @examples
#' # Returns TRUE
#' is_jar_path("beast.jar")
#' is_jar_path("launcher.jar")
#' is_jar_path(get_default_beast2_jar_path())
#' # Returns FALSE
#' is_jar_path("beast")
#' is_jar_path(get_default_beast2_bin_path())
#' @export
is_jar_path <- function(path) {
  # Windows    : BEAST/lib/beast.jar                                            # nolint
  # Non-Windows: beast/lib/launcher.jar                                         # nolint
  !beautier::is_one_na(
    stringr::str_match(
      path, "(.*/)?(launcher|beast)\\.jar$"
    )[1][1]
  )
}
