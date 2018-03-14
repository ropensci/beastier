#' Determines if BEAST2 issues a warning
#' when using the BEAST2 XML input file
#' @inheritParams default_params_doc
#' @param filename name of the BEAST2 XML input file
#' @param beast2_jar_path the path of \code{beast.jar}.
#'   Use \link{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @return TRUE if the file produces a BEAST2 warning, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{are_beast2_input_lines}} to check the lines
#' @export
gives_beast2_warning <- function(
  filename,
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

  # Valid BEAST2 input files will result in an output with 'Done!' at the
  # last line
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

  sum(grepl(x = output, pattern = "WARNING: ")) > 0
}
