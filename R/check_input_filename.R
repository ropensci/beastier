#' Checks the input filename.
#' Will stop if there is a problem with the input filename.
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if the input file is invalid
#' @author Richèl J.C. Bilderbeek
#' @examples
#' check_input_filename(
#'   get_beastier_path("beast2_example_output.log")
#' )
#' @export
check_input_filename <- function(input_filename) {
  beautier::check_file_exists(input_filename, "input_filename")
  invisible(input_filename)
}

#' Checks the input filename.
#' Will stop if there is a problem with the input filename.
#' @inheritParams default_params_doc
#' @return nothing. Will call \code{\link{stop}} if the input file is invalid
#' @author Richèl J.C. Bilderbeek
#' @examples
#' if (is_beast2_installed()) {
#'   check_input_filename_validity(
#'    create_beast2_options(
#'      input_filename = get_beastier_path("2_4.xml")
#'    )
#'  )
#' }
#' @export
check_input_filename_validity <- function(
  beast2_options,
  input_filename = "deprecated",
  beast2_path = "deprecated",
  verbose = "deprecated"
) {
  if (input_filename != "deprecated") {
    stop(
      "'input_filename' is deprecated, ",
      "use 'create_beast2_options(input_filename = input_filename)' instead"
    )
  }
  if (beast2_path != "deprecated") {
    stop(
      "'beast2_path' is deprecated, ",
      "use 'create_beast2_options(beast2_path = beast2_path)' instead"
    )
  }
  if (verbose != "deprecated") {
    stop(
      "'verbose' is deprecated, ",
      "use 'create_beast2_options(verbose = verbose)' instead"
    )
  }

  # Do not be smart yet
  input_filename <- beast2_options$input_filename
  beast2_path <- beast2_options$beast2_path
  verbose <- beast2_options$verbose

  if (
    !beastier::is_beast2_input_file(
      filename = input_filename,
      verbose = verbose,
      beast2_path = beast2_path
    )
  ) {
    stop(
      "'input_filename' must be a valid BEAST2 XML file. ",
      "File '", input_filename, "' is not a valid BEAST2 file. ",
      beastier::is_beast2_input_file(
        input_filename,
        verbose = verbose,
        beast2_path = beast2_path
      )
    )
  }
  invisible(beast2_options)
}
