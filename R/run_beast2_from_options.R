#' Run BEAST2
#' @inheritParams default_params_doc
#' @export
#' @examples
#'   library(testthat)
#'
#'   if (is_beast2_installed() && is_on_ci()) {
#'
#'     beast2_options <- create_beast2_options(
#'       input_filename = get_beastier_path("2_4.xml")
#'     )
#'
#'     expect_false(file.exists(beast2_options$output_log_filename))
#'     expect_false(file.exists(beast2_options$output_trees_filenames))
#'     expect_false(file.exists(beast2_options$output_state_filename))
#'
#'     output <- run_beast2_from_options(beast2_options)
#'
#'     expect_true(length(output) > 40)
#'     expect_true(file.exists(beast2_options$output_log_filename))
#'     expect_true(file.exists(beast2_options$output_trees_filenames))
#'     expect_true(file.exists(beast2_options$output_state_filename))
#'   }
#' @author Richèl J.C. Bilderbeek
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
