#' Function to create a set of BEAST2 options.
#'
#' These BEAST2 options are the R equivalent of the command-line options.
#' @inheritParams default_params_doc
#' @return a BEAST2 options structure,
#' which is a \link{list} of all function arguments,
#' of which all elements are checked (by \link{check_beast2_options})
#' @examples
#' check_empty_beaustier_folders()
#'
#' beast2_options <- create_beast2_options()
#' check_beast2_options(beast2_options)
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_options <- function(
  input_filename = create_temp_input_filename(),
  output_state_filename = create_temp_state_filename(),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  beast2_options <- list(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_path,
    verbose = verbose
  )
  beastier::check_beast2_options(beast2_options)
  beast2_options
}
