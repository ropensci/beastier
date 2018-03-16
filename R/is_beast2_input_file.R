#' Is a file a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param filename name of the BEAST2 XML input file
#' @param beast2_jar_path the path of \code{beast.jar}.
#'   Use \link{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @param show_warnings if TRUE, warnings will shown
#' @return TRUE if the file is valid, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{are_beast2_input_lines}} to check the lines
#' @export
is_beast2_input_file <- function(
  filename,
  show_warnings = FALSE,
  verbose = FALSE,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  if (!file.exists(filename)) {
    stop(
      "'filename' must be the name of an existing file. ",
      "Filename '", filename, "' not found"
    )
  }
  if (!file.exists(beast2_jar_path)) {
    stop(
      "'beast2_jar_path' must be the full path ",
      "of the BEAST2 file 'beast.jar'. ",
      "beast.jar not found at path '", beast2_jar_path, "'"
    )
  }

  # Create the command to let BEAST2 validate the created XML file
  cmd <- beastier::create_beast2_validate_cmd(
    input_filename = filename,
    beast2_jar_path = beast2_jar_path
  )

  # BEAST2 returns an error code.
  # An error code of 0 denotes that the file was valid
  status_code <- system(cmd, ignore.stderr = TRUE, ignore.stdout = TRUE)

  cmds <- unlist(strsplit(x = cmd, split = " "))
  output <- system2(
    cmds[1],
    args = cmds[2:length(cmds)],
    stdout = TRUE,
    stderr = TRUE
  )
  if (verbose) {
    print(output)
  }

  if (show_warnings == TRUE &&
      sum(grepl(x = output, pattern = "WARNING: "))) {
    warning(output[grepl(x = output, pattern = "WARNING: ")])
  }
  # Invalid files are not valid BEAST2 input files
  # Create an if statement here,
  # if there is an input file that violates this assert,
  # and add it to the test
  testit::assert(status_code == 0)

  is_valid <- utils::tail(output, n = 1) == "Done!"
  is_valid
}
