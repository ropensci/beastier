#' Run BEAST2
#' @inheritParams default_params_doc
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the files with names
#'   \code{output_log_filename}, \code{output_trees_filenames}
#'   and \code{output_state_filenames}
#' @export
#' @examples
#' library(testthat)
#'
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   output_log_filename <- tempfile(fileext = ".log")
#'   output_trees_filenames <- tempfile(fileext = ".trees")
#'   output_state_filename <- tempfile(fileext = ".xml.state")
#'
#'   expect_false(file.exists(output_log_filename))
#'   expect_false(file.exists(output_trees_filenames))
#'   expect_false(file.exists(output_state_filename))
#'
#'   output <- run_beast2(
#'     input_filename = get_beastier_path("2_4.xml"),
#'     output_log_filename = output_log_filename,
#'     output_trees_filenames = output_trees_filenames,
#'     output_state_filename = output_state_filename
#'   )
#'
#'   expect_true(length(output) > 40)
#'   expect_true(file.exists(output_log_filename))
#'   expect_true(file.exists(output_trees_filenames))
#'   expect_true(file.exists(output_state_filename))
#' }
#' @author Richèl J.C. Bilderbeek
run_beast2 <- function(
  input_filename,
  output_log_filename = create_default_log_filename(
    input_filename,
    beast2_path,
    verbose
  ),
  output_trees_filenames = create_default_trees_filenames(
    input_filename,
    beast2_path,
    verbose
  ),
  output_state_filename = tempfile(
    pattern = "beastier_", fileext = ".xml.state"
  ),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_working_dir = tempfile(pattern = "beast2_tmp_folder"),
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  beast2_options <- beastier::create_beast2_options(
    input_filename = input_filename,
    output_log_filename = output_log_filename,
    output_trees_filenames = output_trees_filenames,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_working_dir = beast2_working_dir,
    beast2_path = beast2_path,
    verbose = verbose
  )

  beastier::run_beast2_from_options(beast2_options)
}
