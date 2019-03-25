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
#'     expect_silent(check_beast2_path())
#'   }
#' @export
check_beast2_path <- function(beast2_path) {
  if (!file.exists(beast2_path)) {
    stop(
      "'beast2_path' must be the name of an existing file. ",
      "File '", beast2_path, "' not found"
    )
  }
}
