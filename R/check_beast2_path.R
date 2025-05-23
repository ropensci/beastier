#' Checks the BEAST2 \code{.jar} path.
#' Will stop if there is a problem with the BEAST2 \code{.jar} path.
#' @inheritParams default_params_doc
#' @return nothing.
#'   Will call \code{\link{stop}} if the BEAST2 \code{.jar} path has a problem
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed()) {
#'   beast2_path <- get_default_beast2_jar_path()
#'   check_beast2_path(beast2_path)
#' }
#'
#' check_empty_beaustier_folders()
#' @export
check_beast2_path <- function(beast2_path) {
  tryCatch(
    beautier::check_file_exists(beast2_path, "beast2_path"),
    error = function(exception) {
      msg <- paste0(
        "BEAST2 is not found at path '", beast2_path, " \n",
        " \n",
        "Tip: run 'beastierinstall::install_beast2()' \n",
        " \n", exception
      )
      stop(msg)
    }
  )
  invisible(beast2_path)
}
