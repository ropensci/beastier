#' Is the path a path to the BEAST2 jar file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 jar file
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   testthat::expect_false(
#'     beastier:::is_jar_path("beast")
#'   )
#'   testthat::expect_true(
#'     beastier:::is_jar_path("beast.jar")
#'   )
#'   testthat::expect_false(
#'     beastier:::is_jar_path(get_default_beast2_bin_path())
#'   )
#'   testthat::expect_true(
#'     beastier:::is_jar_path(get_default_beast2_jar_path())
#'   )
#' @noRd
is_jar_path <- function(path) {
  !is.na(stringr::str_match(path, "(.*/)?beast\\.jar$")[1][1])
}
