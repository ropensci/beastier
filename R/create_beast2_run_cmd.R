#' Creates the terminal command to run BEAST2
#' @inheritParams default_params_doc
#' @param output_state_filename name of the BEAST2 output file that
#'   stores the state
#'   (usually has a \code{.xml.state} extension)
#' @param n_threads number of threads to use
#' @param use_beagle use BEAGLE if present
#' @return a character vector with the command and
#'   arguments to call BEAST2
#' @examples
#'   cmds <- beastier:::create_beast2_run_cmd(
#'     input_filename = "input.xml",
#'     output_state_filename = "output.xml.state",
#'     beast2_path = beastier:::get_default_beast2_jar_path()
#'   )
#'   testit::assert(cmds[2] == "-jar")
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_run_cmd <- function(
  input_filename,
  output_state_filename,
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = FALSE,
  beast2_path = get_default_beast2_path()
) {
  testit::assert(file.exists(beast2_path))
  testit::assert(file.exists(get_default_java_path())) # nolint internal function
  cmds <- NULL
  if (is_jar_path(beast2_path)) {
    cmds <- c(
      get_default_java_path(),
      "-jar",
      shQuote(beast2_path)
    )
    testit::assert(file.exists(cmds[1]))
    # Cannot do: testit::assert(file.exists(cmds[3]))
    # because that path is quotes
    # and file.exists does not know what to do with that
  } else {
    testit::assert(is_bin_path(beast2_path)) # nolint internal function
    cmds <- beast2_path
    testit::assert(file.exists(cmds[1]))
  }
  if (!is.na(rng_seed)) {
    cmds <- c(cmds, "-seed")
    cmds <- c(cmds, rng_seed)
  }
  if (!is.na(n_threads)) {
    cmds <- c(cmds, "-threads")
    cmds <- c(cmds, n_threads)
  }
  if (use_beagle == TRUE) {
    cmds <- c(cmds, "-beagle")
  }
  cmds <- c(cmds, "-statefile")
  cmds <- c(cmds, paste0("\"", output_state_filename, "\""))
  testit::assert(file.exists(cmds[1]))
  if (overwrite == TRUE) {
    cmds <- c(cmds, "-overwrite")
  }
  testit::assert(file.exists(cmds[1]))
  cmds <- c(cmds, paste0("\"", input_filename, "\""))
  testit::assert(file.exists(cmds[1]))
  cmds
}
