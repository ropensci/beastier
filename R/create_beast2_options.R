#' Function to create a set of BEAST2 options.
#'
#' These BEAST2 options are the R equivalent of the command-line options.
#' @inheritParams default_params_doc
#' @return a BEAST2 options structure
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   beast2_options <- create_beast2_options()
#' @export
create_beast2_options <- function(
  input_filename = tempfile(fileext = ".xml"),
  output_log_filename = tempfile(fileext = ".log"),
  output_trees_filenames = tempfile(fileext = ".trees"),
  output_state_filename = tempfile(fileext = ".xml.state"),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  beast2_options <- list(
    input_filename = input_filename,
    output_log_filename = output_log_filename,
    output_trees_filenames = output_trees_filenames,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_path = beast2_path,
    verbose = verbose
  )
  check_beast2_options(beast2_options) # nolint beautier function
  beast2_options
}
