#' Creates the terminal command to run BEAST2
#' @param input_filename name of the BEAST2 input file
#'   (usually has a \code{.xml} extension)
#' @param output_state_filename name of the BEAST2 output file that
#'   stores the state
#'   (usually has a \code{.xml.state} extension)
#' @param rng_seed the RNG seed
#' @param n_threads number of threads to use
#' @param use_beagle use BEAGLE if present
#' @param overwrite_state_file set to TRUE to overwrite the file with name
#'   \code{output_state_filename} if it already exists
#' @param beast2_jar_path name of the BEAST2 jar file
#'   (usually has a \code{.jar} extension).
#'   Use \link{get_default_beast2_jar_path} to get
#'   the default BEAST jar file's path
#' @author Richel J.C. Bilderbeek
#' @export
create_beast2_run_cmd <- function(
  input_filename,
  output_state_filename,
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite_state_file = TRUE,
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
  if (overwrite_state_file == TRUE) {
    cmd <- paste(cmd, "-overwrite")
  }

  cmd <- paste0(cmd, " \"", input_filename, "\"")
  cmd
}
