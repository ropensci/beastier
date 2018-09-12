#' Is the path a path to the BEAST2 binary file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 binary file
#' @author Richel J.C. Bilderbeek
#' @examples
#'   testthat::expect_true(beastier:::is_bin_path("beast"))
#'   testthat::expect_false(beastier:::is_bin_path("beast.jar"))
#'   testthat::expect_true(beastier:::is_bin_path(get_default_beast2_bin_path()))
#'   testthat::expect_false(beastier:::is_bin_path(get_default_beast2_jar_path()))
#' @noRd
is_bin_path <- function(path) {
  !is.na(stringr::str_match(path, "(.*/)?beast$")[1][1])
}
