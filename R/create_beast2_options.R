#' Function to create a set of BEAST2 options.
#'
#' These BEAST2 options are the R equivalent of the command-line options.
#' @inheritParams default_params_doc
#' @return a BEAST2 options structure
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' beast2_options <- create_beast2_options()
#'
#' expect_true("input_filename" %in% names(beast2_options))
#' expect_true("output_state_filename" %in% names(beast2_options))
#' expect_true("rng_seed" %in% names(beast2_options))
#' expect_true("n_threads" %in% names(beast2_options))
#' expect_true("use_beagle" %in% names(beast2_options))
#' expect_true("overwrite" %in% names(beast2_options))
#' expect_true("beast2_path" %in% names(beast2_options))
#' expect_true("verbose" %in% names(beast2_options))
#'
#' expect_silent(check_beast2_options(beast2_options))
#' @export
create_beast2_options <- function(
  input_filename = tempfile(fileext = ".xml"),
  output_log_filename = "output_log_filename_is_deprecated",
  output_trees_filenames = "output_trees_filenames_is_deprecated",
  output_state_filename = tempfile(fileext = ".xml.state"),
  rng_seed = NA,
  n_threads = NA,
  use_beagle = FALSE,
  overwrite = TRUE,
  beast2_working_dir = file.path(
    get_default_beast2_working_dir(), basename(tempfile())
  ),
  beast2_path = get_default_beast2_path(),
  verbose = FALSE
) {
  # Check for deprecated argument names
  calls <- names(sapply(match.call(), deparse))[-1]
  if (any("output_log_filename" %in% calls)) {
    stop(
      "'output_log_filename' is deprecated, it is stored in the BEAST2 XML"
    )
  }
  if (any("output_trees_filenames" %in% calls)) {
    stop(
      "'output_trees_filenames' is deprecated, it is stored in the BEAST2 XML"
    )
  }

  beast2_options <- list(
    input_filename = input_filename,
    output_state_filename = output_state_filename,
    rng_seed = rng_seed,
    n_threads = n_threads,
    use_beagle = use_beagle,
    overwrite = overwrite,
    beast2_working_dir = beast2_working_dir,
    beast2_path = beast2_path,
    verbose = verbose
  )
  beastier::check_beast2_options(beast2_options)
  beast2_options
}
