#' Is the path a path to the BEAST2 binary file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 binary file
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   if (is_beast2_installed()) {
#'     expect_true(is_bin_path("beast"))
#'     expect_true(is_bin_path("BEAST.exe"))
#'     expect_false(is_bin_path("beast.jar"))
#'     expect_true(is_bin_path(get_default_beast2_bin_path()))
#'     expect_false(is_bin_path(get_default_beast2_jar_path()))
#'   }
#' @export
is_bin_path <- function(path) {
  !beautier::is_one_na(stringr::str_match(
    path, "(.*/)?(beast|BEAST\\.exe)$")[1][1]
  )
}

#' Is the path a path to the BEAST2 binary file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 binary file
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_false(is_win_bin_path("beast"))
#'   expect_true(is_win_bin_path("BEAST.exe"))
#'   expect_false(is_win_bin_path("beast.jar"))
#' @noRd
is_win_bin_path <- function(path) {
  !beautier::is_one_na(stringr::str_match(
    path, "(.*/)?BEAST\\.exe$")[1][1]
  )
}
