#' Creates the terminal command to run BEAST2
#' @inheritParams default_params_doc
#' @param output_state_filename name of the BEAST2 output file that
#'   stores the state
#'   (usually has a \code{.xml.state} extension)
#' @param use_beagle use BEAGLE if present
#' @return a character vector with the command and
#'   arguments to call BEAST2
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed()) {
#'   create_beast2_run_cmd(
#'     input_filename = "input.xml",
#'     output_state_filename = "output.xml.state",
#'     beast2_path = get_default_beast2_jar_path()
#'   )
#' }
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_run_cmd <- function(
  input_filename,
  output_state_filename,
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = FALSE,
  beast2_path = beastier::get_default_beast2_path(),
  verbose = FALSE
) {
  beast2_options <- beastier::create_beast2_options(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_path,
    verbose = verbose
  )
  create_beast2_run_cmd_from_options(beast2_options)
}
