#' Run BEAST2
#' @inheritParams default_params_doc
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the file with name \code{output_state_filenames}
#' @export
#' @examples
#' check_empty_beaustier_folders()
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   output_state_filename <- create_temp_state_filename()
#'
#'   run_beast2(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     output_state_filename = output_state_filename
#'
#'   )
#'   file.remove(output_state_filename)
#'   remove_beaustier_folders()
#' }
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
run_beast2 <- function(
  input_filename,
  output_state_filename = create_temp_state_filename(),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_path = get_default_beast2_path(),
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
  beastier::run_beast2_from_options(beast2_options)
}
