#' Is the path a path to the BEAST2 binary file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 binary file
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   if (is_beast2_installed()) {
#'     testthat::expect_true(is_bin_path("beast"))
#'     testthat::expect_true(is_bin_path("BEAST.exe"))
#'     testthat::expect_false(is_bin_path("beast.jar"))
#'     testthat::expect_true(is_bin_path(get_default_beast2_bin_path()))
#'     testthat::expect_false(is_bin_path(get_default_beast2_jar_path()))
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
#'   testthat::expect_false(
#'     beastier::is_win_bin_path("beast")
#'   )
#'   testthat::expect_true(
#'     beastier::is_win_bin_path("BEAST.exe")
#'   )
#'   testthat::expect_false(
#'     beastier::is_win_bin_path("beast.jar")
#'   )
#' @noRd
is_win_bin_path <- function(path) {
  !beautier::is_one_na(stringr::str_match(
    path, "(.*/)?BEAST\\.exe$")[1][1]
  )
}
