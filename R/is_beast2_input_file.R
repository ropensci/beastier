#' Is a file a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param filename name of the BEAST2 XML input file
#' @param beast_jar_path the path of \code{beast.jar}
#' @return TRUE if the file is valid, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{are_beast2_input_lines}} to check the lines
#' @export
is_beast2_input_file <- function(
  filename,
  verbose = FALSE,
  beast_jar_path = "~/Programs/beast/lib/beast.jar"
) {
  if (!file.exists(filename)) {
    stop(
      "'filename' must be the name of an existing file. ",
      "Filename '", filename, "' not found"
    )
  }
  if (!file.exists(beast_jar_path)) {
    stop(
      "'beast_jar_path' must be the fullpath of the BEAST2 file 'beast2.jar'. ",
      "beast.jar not found at path '", beast_jar_path, "'"
    )
  }

  # Create the command to let BEAST2 validate the created XML file
  cmd <- beastier::create_beast2_validate_cmd(
    input_filename = filename,
    beast_jar_path = beast_jar_path
  )

  # BEAST2 returns an error code.
  # An error code of 0 denotes that the file was valid
  status_code <- system(cmd, ignore.stderr = TRUE, ignore.stdout = TRUE)

  # Invalid files are not valid BEAST2 input files
  # Create an if statement here,
  # if there is an input file that violates this assert,
  # and add it to the test
  testit::assert(status_code == 0)

  # Valid BEAST2 input files will result in an output with 'Done!' at the
  # last line
  output <- system(cmd, intern = TRUE, ignore.stderr = TRUE)
  if (verbose) {
    print(output)
  }
  is_valid <- utils::tail(output, n = 1) == "Done!"
  is_valid
}
