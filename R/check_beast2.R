#' Check if \code{BEAST2} is installed properly.
#'
#' Calls \code{stop} if BEAST2 is improperly installed
#' @inheritParams default_params_doc
#' @return nothing
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed()) {
#'   expect_silent(check_beast2())
#' } else {
#'   expect_error(check_beast2())
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
check_beast2 <- function(
  beast2_path = get_default_beast2_path()
) {
  is_valid <- FALSE
  tryCatch({
    is_valid <- is_beast2_input_file(
      filename = beastier::get_beastier_path("anthus_2_4.xml"),
      beast2_path = beast2_path
    )
  }, error = function(e) {
      stop(e)
    }
  )
  if (!is_valid) {
    stop("BEAST2 invalid")
  }
}
