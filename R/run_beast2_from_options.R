#' Run BEAST2
#' @inheritParams default_params_doc
#' @export
#' @examples
#'   beast2_options <- create_beast2_options(
#'     output_log_filename = tempfile(fileext = ".log"),
#'     output_trees_filenames = tempfile(fileext = ".trees"),
#'     output_state_filename = tempfile(fileext = ".xml.state")
#'   )
#'
#'   output <- run_beast2_from_options(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     beast2_options = beast2_options
#'   )
#'
#'   testit::assert(length(output) > 40)
#'   testit::assert(file.exists(beast2_options$output_log_filename))
#'   testit::assert(file.exists(beast2_options$output_trees_filenames))
#'   testit::assert(file.exists(beast2_options$output_state_filename))
#'
#' @author Richel J.C. Bilderbeek
run_beast2_from_options <- function(
  beast2_options = create_beast2_options()
) {
  check_beast2_options(beast2_options) # nolint beastier function

  run_beast2(
    input_filename = beast2_options$input_filename,
    output_log_filename = beast2_options$output_log_filename,
    output_trees_filenames = beast2_options$output_trees_filenames,
    output_state_filename = beast2_options$output_state_filename,
    rng_seed = beast2_options$rng_seed,
    n_threads = beast2_options$n_threads,
    use_beagle = beast2_options$use_beagle,
    overwrite  = beast2_options$overwrite,
    beast2_path = beast2_options$beast2_path,
    verbose = beast2_options$verbose
  )
}
