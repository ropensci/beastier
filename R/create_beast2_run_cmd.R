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
#'   cmd <- create_beast2_run_cmd(
#'     input_filename = "input.xml",
#'     output_state_filename = "output.xml.state",
#'     beast2_path = get_default_beast2_jar_path()
#'   )
#'   testit::assert(cmd[1] == "java")
#'   testit::assert(cmd[2] == "-jar")
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
  if (is_jar_path(beast2_path)) {
    cmd <- c(
      "java",
      "-jar",
      paste0("\"", beast2_path, "\"")
    )
  } else {
    testit::assert(is_bin_path(beast2_path))
    cmd <- paste0("\"", beast2_path, "\"")
  }
  if (!is.na(rng_seed)) {
    cmd <- c(cmd, "-seed")
    cmd <- c(cmd, rng_seed)
  }
  if (!is.na(n_threads)) {
    cmd <- c(cmd, "-threads")
    cmd <- c(cmd, n_threads)
  }
  if (use_beagle == TRUE) {
    cmd <- c(cmd, "-beagle")
  }
  cmd <- c(cmd, "-statefile")
  cmd <- c(cmd, paste0("\"", output_state_filename, "\""))
  if (overwrite == TRUE) {
    cmd <- c(cmd, "-overwrite")
  }
  c(cmd, paste0("\"", input_filename, "\""))
}
