#' Checks the input filename.
#' Will stop if there is a problem with the input filename.
#' @param input_filename the name of a BEAST2 input XML file
#' @return nothing. Will call \code{\link{stop}} if the input file is invalid
#' @author Richel J.C. Bilderbeek
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
#' @param input_filename the name of a BEAST2 input XML file
#' @return nothing. Will call \code{\link{stop}} if the input file is invalid
#' @author Richel J.C. Bilderbeek
check_input_filename_validity <- function(
  input_filename,
  beast2_jar_path,
  verbose
) {

  if (
    !is_beast2_input_file(
      filename = input_filename,
      verbose = verbose,
      beast2_jar_path = beast2_jar_path
    )
  ) {
    stop(
      "'input_filename' must be a valid BEAST2 XML file",
      "File '", input_filename, "' is not a valid BEAST2 file",
      is_beast2_input_file( # nolint internal function
        input_filename,
        verbose = verbose,
        beast2_jar_path = beast2_jar_path)
    )
  }
}
