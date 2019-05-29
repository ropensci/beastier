#' Do a minimal BEAST2 run
#'
#' To achieve this, \link{run_beast2_from_options} is called.
#' @inheritParams default_params_doc
#' @return The text sent to \code{STDOUT} and \code{STDERR}.
#'   It will create the files with names
#'   \code{output_log_filename}, \code{output_trees_filenames}
#'   and \code{output_state_filenames}
#' @export
#' @examples
#'   library(testthat)
#'
#'   if (is_beast2_installed() && is_on_ci()) {
#'
#'     expect_silent(do_minimal_run())
#'
#'   }
#' @author Richèl J.C. Bilderbeek
do_minimal_run <- function() {
  run_beast2_from_options(
    create_beast2_options(
      input_filename = get_beastier_path("2_4.xml"),
      rng_seed = 314
    )
  )
}