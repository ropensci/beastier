#' Checks the BEAST2 \code{.jar} path.
#' Will stop if there is a problem with the BEAST2 \code{.jar} path.
#' @inheritParams default_params_doc
#' @return nothing.
#'   Will call \code{\link{stop}} if the BEAST2 \code{.jar} path has a problem
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   if (is_beast2_installed()) {
#'     beast2_path <- get_default_beast2_jar_path()
#'     expect_silent(check_beast2_path(beast2_path))
#'   }
#' @export
check_beast2_path <- function(beast2_path) {
  beautier::check_file_exists(beast2_path, "beast2_path")
}
