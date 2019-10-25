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
  check_beast2_options_names(beast2_options) # nolint beastier function
  check_beast2_options_data_types(beast2_options) # nolint beastier function
  # Do not check if the BEAST2 path already/still exist.
  # It shouldn't be checked by here, only when actually running BEAST2.
  # By doing so, data with beast2_options can be analysed on different computers
  check_beast2_options_filenames_differ(beast2_options) # nolint beastier function
  check_beast2_options_filenames_not_in_working_dir(beast2_options) # nolint beastier function
}

#' Check if the \code{beast2_options}, which is a list,
#' has all the elements needed.
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_options} to check
#'   the entire \code{beast2_options} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_options_names <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_options
) {
  argument_names <- c(
    "input_filename",
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
}

#' Check if the \code{beast2_options}, which is a list,
#' has all elements of the right data types
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_options} to check
#'   the entire \code{beast2_options} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_options_data_types <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_options
) {
  if (!assertive::is_a_string(beast2_options$input_filename)) {
    stop("'input_filename' must be one character string")
  }
  if (!assertive::is_a_string(beast2_options$output_state_filename)) {
    stop("'output_state_filename' must be one character string")
  }
  beastier::check_rng_seed(beast2_options$rng_seed)
  beastier::check_n_threads(beast2_options$n_threads)
  if (!beautier::is_one_bool(beast2_options$use_beagle)) {
    stop("'use_beagle' must be one boolean")
  }
  if (!beautier::is_one_bool(beast2_options$overwrite)) {
    stop("'overwrite' must be one boolean")
  }
  if (!assertive::is_a_string(beast2_options$beast2_working_dir)) {
    stop("'beast2_working_dir' must be one character string")
  }
  if (!assertive::is_a_string(beast2_options$beast2_path)) {
    stop("'beast2_path' must be one character string")
  }
  if (!beautier::is_one_bool(beast2_options$verbose)) {
    stop("'verbose' must be one boolean")
  }
}

#' Check if the filenames in \code{beast2_options} differ
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_options} to check
#'   the entire \code{beast2_options} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_options_filenames_differ <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_options
) {
  if (beast2_options$input_filename == beast2_options$output_state_filename) {
    stop("'input_filename' and 'output_state_filename' must differ")
  }
}

#' Check if the filenames in \code{beast2_options} have a
#' different folder than the working directory
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_options} to check
#'   the entire \code{beast2_options} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_options_filenames_not_in_working_dir <- function( # nolint indeed a long function name, which is fine for an internal function
  beast2_options
) {
  # Because 'dirname' returns a normalized path,
  # normalize beast2_working_dir as well
  beast2_working_dir <- normalizePath(
    beast2_options$beast2_working_dir,
    mustWork = FALSE
  )
  if (normalizePath(
      dirname(beast2_options$input_filename), mustWork = FALSE
    ) == beast2_working_dir) {
    stop(
      "'beast2_working_dir' must be a different folder than ",
      "the folder of 'input_filename'"
    )
  }
  if (normalizePath(
    dirname(beast2_options$output_state_filename), mustWork = FALSE
    ) == beast2_working_dir) {
    stop(
      "'beast2_working_dir' must be a different folder than ",
      "the folder of 'output_state_filename'"
    )
  }
}
