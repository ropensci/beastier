#' Check if the \code{beast2_options} is a valid BEAST2 options object.
#'
#' Calls \code{stop} if the BEAST2 option object is invalid
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{create_beast2_options} to create a valid
#'   BEAST2 options object
#' @examples
#'  library(testthat)
#'
#'  expect_silent(check_beast2_options(create_beast2_options()))
#'
#'  # Must stop on nonsense
#'  expect_error(check_beast2_options(beast2_options = "nonsense"))
#'  expect_error(check_beast2_options(beast2_options = NULL))
#'  expect_error(check_beast2_options(beast2_options = NA))
#' @author Richèl J.C. Bilderbeek
#' @export
check_beast2_options <- function(
  beast2_options
) {
  argument_names <- c(
    "input_filename", "output_log_filename", "output_trees_filenames",
    "output_state_filename",
    "rng_seed", "n_threads", "use_beagle", "overwrite", "beast2_working_dir",
    "beast2_path", "verbose"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(beast2_options)) {
      stop(
        "'", arg_name, "' must be an element of an 'beast2_options'. ",
        "Tip: use 'create_beast2_options'"
      )
    }
  }
  if (length(beast2_options$input_filename) != 1 ||
    !is.character(beast2_options$input_filename)) {
    stop("'input_filename' must be one character string")
  }
  if (length(beast2_options$output_log_filename) != 1 ||
    !is.character(beast2_options$output_log_filename)) {
    stop("'output_log_filename' must be one character string")
  }
  if (length(beast2_options$output_trees_filenames) != 1 ||
    !is.character(beast2_options$output_trees_filenames)) {
    stop("'output_trees_filenames' must be one character string")
  }
  if (length(beast2_options$output_state_filename) != 1 ||
    !is.character(beast2_options$output_state_filename)) {
    stop("'output_state_filename' must be one character string")
  }
  check_rng_seed(beast2_options$rng_seed) # nolint beastier function
  check_n_threads(beast2_options$n_threads) # nolint beastier function
  if (!beautier::is_one_bool(beast2_options$use_beagle)) {
    stop("'use_beagle' must be one boolean")
  }
  if (!beautier::is_one_bool(beast2_options$overwrite)) {
    stop("'overwrite' must be one boolean")
  }
  if (length(beast2_options$beast2_working_dir) != 1 ||
    !is.character(beast2_options$beast2_working_dir)) {
    stop("'beast2_working_dir' must be one character string")
  }
  if (length(beast2_options$beast2_path) != 1 ||
    !is.character(beast2_options$beast2_path)) {
    stop("'beast2_path' must be one character string")
  }
  if (!beautier::is_one_bool(beast2_options$verbose)) {
    stop("'verbose' must be one boolean")
  }
}
