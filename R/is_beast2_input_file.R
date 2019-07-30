#' Is a file a valid BEAST2 input file?
#' @inheritParams default_params_doc
#' @param filename name of the BEAST2 XML input file
#' @param show_warnings if TRUE, warnings will shown
#' @return TRUE if the file is valid, FALSE if not
#' @author Richèl J.C. Bilderbeek
#' @note this function only works on standard BEAST2 input files:
#'     if a BEAST2 input file is modified to use a certain BEAST2 package,
#'     this function will label it as an invalid file
#' @seealso Use \code{\link{are_beast2_input_lines}} to check the lines
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   filename <- get_beastier_path("anthus_2_4.xml")
#'   expect_true(file.exists(filename))
#'   expect_true(is_beast2_input_file(filename))
#'
#'   filename <- get_beastier_path("beast2_example_output.log")
#'   expect_true(file.exists(filename))
#'   expect_false(is_beast2_input_file(filename))
#' }
#' @export
is_beast2_input_file <- function(
  filename,
  show_warnings = FALSE,
  verbose = FALSE,
  beast2_path = get_default_beast2_path()
) {
  beautier::check_file_exists(filename, "filename")
  if (is_win_bin_path(beast2_path)) {
   stop("Cannot use the Windows executable BEAST2.exe in scripts")
  }
  if (!file.exists(beast2_path)) {
    stop(
      "'beast2_path' must be the full path ",
      "of either 'beast' or 'launcher.jar'. ",
      "Both not found at path '", beast2_path, "'"
    )
  }

  # Create the command to let BEAST2 validate the created XML file
  testit::assert(length(filename) == 1)
  testit::assert(length(beast2_path) == 1)
  cmds <- beastier::create_beast2_validate_cmd(
    input_filename = filename,
    beast2_path = beast2_path
  )
  beautier::check_file_exists(cmds[1], "cmds[1]")
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
