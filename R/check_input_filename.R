#' Checks the input filename.
#' Will stop if there is a problem with the input filename.
#' @inheritParams default_params_doc
#' @return nothing. Will call \code{\link{stop}} if the input file is invalid
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_error(check_input_filename(tempfile()))
#'   expect_silent(
#'     check_input_filename(
#'       get_beastier_path("beast2_example_output.log")
#'     )
#'   )
#' @export
check_input_filename <- function(input_filename) {
  if (!file.exists(input_filename)) {
    stop(
      "'input_filename' must be the name of an existing file. ",
      "File '", input_filename, "' not found"
    )
  }
}

#' Checks the input filename.
#' Will stop if there is a problem with the input filename.
#' @inheritParams default_params_doc
#' @return nothing. Will call \code{\link{stop}} if the input file is invalid
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   library(testthat)
#'
#'   expect_error(check_input_filename_validity(tempfile()))
#'   expect_error(
#'     check_input_filename_validity(
#'       get_beastier_path("beast2_example_output.log")
#'     )
#'   )
#'   expect_silent(
#'     check_input_filename_validity(
#'       get_beastier_path("2_4.xml")
#'     )
#'   )
#' @noRd
check_input_filename_validity <- function(
  input_filename,
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {

  if (
    !is_beast2_input_file(
      filename = input_filename,
      verbose = verbose,
      beast2_path = beast2_path
    )
  ) {
    stop(
      "'input_filename' must be a valid BEAST2 XML file. ",
      "File '", input_filename, "' is not a valid BEAST2 file. ",
      is_beast2_input_file( # nolint internal function
        input_filename,
        verbose = verbose,
        beast2_path = beast2_path
      )
    )
  }
}
