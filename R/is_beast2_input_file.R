#' Is a file a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param filename name of the BEAST2 XML input file
#' @param show_warnings if TRUE, warnings will shown
#' @return TRUE if the file is valid, FALSE if not
#' @author Richel J.C. Bilderbeek
#' @seealso Use \code{\link{are_beast2_input_lines}} to check the lines
#' @export
is_beast2_input_file <- function(
  filename,
  show_warnings = FALSE,
  verbose = FALSE,
  beast2_path = get_default_beast2_path()
) {
  if (!file.exists(filename)) {
    stop(
      "'filename' must be the name of an existing file. ",
      "Filename '", filename, "' not found"
    )
  }
  if (!file.exists(beast2_path)) {
    stop(
      "'beast2_path' must be the full path ",
      "of either 'beast' or 'beast.jar'. ",
      "Both not found at path '", beast2_path, "'"
    )
  }
  if (rappdirs::app_dir()$os == "win" && is_bin_path(beast2_path)) {
    stop("Cannot use the Windows exectuable BEAST2.exe is scripts")
  }

  # Create the command to let BEAST2 validate the created XML file
  testit::assert(length(filename) == 1)
  testit::assert(length(beast2_path) == 1)
  cmds <- beastier::create_beast2_validate_cmd(
    input_filename = filename,
    beast2_path = beast2_path
  )
  testit::assert(file.exists(cmds[1]))
  output <- system2(
    cmds[1],
    args = cmds[-1],
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

  is_valid <- utils::tail(output, n = 1) == "Done!"
  is_valid
}
