#' Is the path a path to the BEAST2 binary file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 binary file
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed()) {
#'   # TRUE
#'   is_bin_path("beast")
#'   is_bin_path("BEAST.exe")
#'   is_bin_path(get_default_beast2_bin_path())
#'   # FALSE
#'   is_bin_path("launcher.jar")
#'   is_bin_path(get_default_beast2_jar_path())
#' }
#'
#' check_empty_beaustier_folders()
#' @export
is_bin_path <- function(path) {
  !beautier::is_one_na(
    stringr::str_match(
      path,
      "(.*/)?(beast|BEAST(2)?\\.exe)$"
    )[1][1]
  )
}

#' Is the path a path to the BEAST2 binary file?
#' Does not check if the file at that path is present
#' @param path a string to a path
#' @return TRUE if the path is a path to a BEAST2 binary file
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' # TRUE
#' is_win_bin_path("BEAST.exe")
#' # FALSE
#' is_win_bin_path("beast")
#' is_win_bin_path("launcher.jar")
#'
#' check_empty_beaustier_folders()
#' @export
is_win_bin_path <- function(path) {
  !beautier::is_one_na(
    stringr::str_match(
      path,
      "(.*/)?BEAST2?\\.exe$"
    )[1][1]
  )
}
