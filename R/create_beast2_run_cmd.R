#' Creates the terminal command to run BEAST2
#' @inheritParams default_params_doc
#' @param output_state_filename name of the BEAST2 output file that
#'   stores the state
#'   (usually has a \code{.xml.state} extension)
#' @param rng_seed the RNG seed
#' @param n_threads number of threads to use
#' @param use_beagle use BEAGLE if present
#' @param overwrite if TRUE: overwrite the \code{.log}
#'   and \code{.trees} files if one of these exists.
#'   If FALSE, BEAST2 will not be started if one of these files exists
#' @return one character string that calls the BEAST2
#'   \code{.jar} file, starting with \code{"java -jar "}
#' @examples
#'   cmd <- create_beast2_run_cmd(
#'     input_filename = "input.xml",
#'     output_state_filename = "output.xml.state"
#'   )
#'   testit::assert(substr(cmd, 1, 10) == "java -jar ")
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_run_cmd <- function(
  input_filename,
  output_state_filename,
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = FALSE,
  beast2_jar_path = get_default_beast2_jar_path()
) {
  cmd <- paste0("java -jar \"", beast2_jar_path, "\"")
  if (!is.na(rng_seed)) {
    cmd <- paste(cmd, "-seed", rng_seed)
  }
  if (!is.na(n_threads)) {
    cmd <- paste(cmd, "-threads", n_threads)
  }
  if (use_beagle == TRUE) {
    cmd <- paste(cmd, "-beagle")
  }
  cmd <- paste0(cmd, " -statefile \"", output_state_filename, "\"")
  if (overwrite == TRUE) {
    cmd <- paste(cmd, "-overwrite")
  }

  cmd <- paste0(cmd, " \"", input_filename, "\"")
  cmd
}
