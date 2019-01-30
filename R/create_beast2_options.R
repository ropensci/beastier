#' Function to create a set of BEAST2 options.
#'
#' BEAUti options are settings that differ between BEAUti
#' version. The use of these options is mostly for testing
#' older versions
#' Whatever option chosen here, the created XML file will be valid.
#' @inheritParams default_params_doc
#' @return a BEAST2 options structure
#' @author Richel J.C. Bilderbeek
#' @examples
#'   beast2_options <- create_beast2_options()
#' @export
create_beast2_options <- function(
  output_log_filename = tempfile(fileext = "log"),
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
