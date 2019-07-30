#' Is the path a path to the BEAST2 jar file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 jar file
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_false(is_jar_path("beast"))
#'   expect_true(is_jar_path("beast.jar"))
#'   expect_true(is_jar_path("launcher.jar"))
#'   expect_false(is_jar_path(get_default_beast2_bin_path()))
#'   expect_true(is_jar_path(get_default_beast2_jar_path()))
#' @noRd
is_jar_path <- function(path) {
  # Windows    : BEAST/lib/beast.jar                                            # nolint
  # Non-Windows: beast/lib/launcher.jar                                         # nolint
  !beautier::is_one_na(stringr::str_match(
    path, "(.*/)?(launcher|beast)\\.jar$")[1][1]
  )
}
