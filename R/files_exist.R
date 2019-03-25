#' Checks if all files exist.
#'
#' Multi-file \link{file.exists} function
#' @param filenames one or more filename
#' @return TRUE if all files exists, FALSE otherwise
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   filename_1 <- get_beastier_path("beast2_example_output.log")
#'   filename_2 <- get_beastier_path("beast2_example_output.trees")
#'   absent <- tempfile()
#'
#'   expect_true(files_exist(filename_1))
#'   expect_true(files_exist(filename_2))
#'   expect_false(files_exist(absent))
#'
#'   expect_true(files_exist(c(filename_1, filename_2)))
#'   expect_false(files_exist(c(filename_1, absent)))
#'   expect_false(files_exist(c(absent, filename_2)))
#' @noRd
files_exist <- function(filenames) {
  for (filename in filenames) {
    if (!file.exists(filename)) {
      return(FALSE)
    }
  }
  TRUE
}
