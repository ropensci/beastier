#' Check if the \code{beast2_internal_filenames} is a valid BEAST2 options object.
#'
#' Calls \code{stop} if the BEAST2 option object is invalid
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{create_beast2_internal_filenames} to create a valid
#'   BEAST2 options object
#' @examples
#' library(testthat)
#'
#' expect_silent(
#'   check_beast2_internal_filenames(
#'     create_beast2_internal_filenames(
#'       create_beast2_options(
#'         input_filename = get_beastier_path("2_4.xml")
#'       )
#'     )
#'   )
#' )
#'
#' # Must stop on nonsense
#' expect_error(check_beast2_internal_filenames("nonsense"))
#' expect_error(check_beast2_internal_filenames(NULL))
#' expect_error(check_beast2_internal_filenames(NA))
#' @author Richèl J.C. Bilderbeek
#' @export
check_beast2_internal_filenames <- function(
  beast2_internal_filenames
) {
  check_beast2_internal_filenames_names(beast2_internal_filenames) # nolint beastier function
  check_beast2_internal_filenames_data_types(beast2_internal_filenames) # nolint beastier function
  check_beast2_internal_filenames_filenames_differ(beast2_internal_filenames) # nolint beastier function
}

#' Check if the \code{beast2_internal_filenames}, which is a list,
#' has all the elements needed.
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_internal_filenames} to check
#'   the entire \code{beast2_internal_filenames} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_internal_filenames_names <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_internal_filenames
) {
  argument_names <- c(
    "input_filename_full",
    "actual_log_filename",
    "actual_trees_filenames",
    "output_log_filename_full",
    "output_trees_filenames_full",
    "output_state_filename_full"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(beast2_internal_filenames)) {
      stop(
        "'", arg_name, "' must be an element of an 'beast2_internal_filenames'. ",
        "Tip: use 'create_beast2_internal_filenames'"
      )
    }
  }
}

#' Check if the \code{beast2_internal_filenames}, which is a list,
#' has all elements of the right data types
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_internal_filenames} to check
#'   the entire \code{beast2_internal_filenames} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_internal_filenames_data_types <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_internal_filenames
) {
  # Shorthand notation
  bifs <- beast2_internal_filenames
  if (!assertive::is_a_string(bifs$input_filename_full)) {
    stop("'input_filename_full' must be one character string")
  }
  if (!assertive::is_a_string(bifs$actual_log_filename)) {
    stop("'actual_log_filename' must be one character string")
  }
  if (!assertive::is_a_string(bifs$actual_trees_filenames)) {
    stop("'actual_trees_filenames' must be one character string")
  }
  if (!assertive::is_a_string(bifs$output_log_filename_full)) {
    stop("'output_log_filename_full' must be one character string")
  }
  if (!assertive::is_a_string(bifs$output_trees_filenames_full)) {
    stop("'output_trees_filenames_full' must be one character string")
  }
  if (!assertive::is_a_string(bifs$output_state_filename_full)) {
    stop("'output_state_filename_full' must be one character string")
  }
}

#' Check if the filenames in \code{beast2_internal_filenames} differ
#'
#' Calls \code{stop} if not.
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{check_beast2_internal_filenames} to check
#'   the entire \code{beast2_internal_filenames} object
#' @author Richèl J.C. Bilderbeek
#' @noRd
check_beast2_internal_filenames_filenames_differ <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_internal_filenames
) {
  # Shorthand notation
  filenames <- unlist(beast2_internal_filenames)
  if (length(unique(filenames)) != length(filenames)) {
    stop("All BEAST2 internal filenames must be unique")
  }
}
