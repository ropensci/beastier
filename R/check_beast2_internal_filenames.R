#' Check if the \code{beast2_internal_filenames}
#' is a valid BEAST2 internal filenames object.
#'
#' Calls \code{stop} if the BEAST2 internal filenames object is invalid
#' @inheritParams default_params_doc
#' @return nothing
#' @seealso Use \link{create_beast2_internal_filenames}
#'   to create a valid BEAST2 internal filenames object
#' @examples
#'
#' if (beastier::is_beast2_installed()) {
#'   check_beast2_internal_filenames(
#'     create_beast2_internal_filenames(
#'       create_beast2_options(
#'         input_filename = get_beastier_path("2_4.xml")
#'       )
#'     )
#'   )
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
check_beast2_internal_filenames <- function( # nolint indeed a long function, which is fine for internal functions
  beast2_internal_filenames
) {
  beastier::check_beast2_internal_filenames_names(
    beast2_internal_filenames
  )
  beastier::check_beast2_internal_filenames_data_types(
    beast2_internal_filenames
  )
  beastier::check_beast2_internal_filenames_filenames_differ(
    beast2_internal_filenames
  )
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
#' @export
check_beast2_internal_filenames_names <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_internal_filenames
) {
  argument_names <- c(
    "input_filename_full",
    "output_state_filename_full"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(beast2_internal_filenames)) {
      stop(
        "'", arg_name, "' must be an element of an ",
        "'beast2_internal_filenames'. \n",
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
#' @export
check_beast2_internal_filenames_data_types <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_internal_filenames
) {
  # Shorthand notation
  bifs <- beast2_internal_filenames
  if (!assertive::is_a_string(bifs$input_filename_full)) {
    stop("'input_filename_full' must be one character string")
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
#' @export
check_beast2_internal_filenames_filenames_differ <- function( # nolint long function name indeed, which is fine for an internal function
  beast2_internal_filenames
) {
  # Shorthand notation
  filenames <- unlist(beast2_internal_filenames)
  if (length(unique(filenames)) != length(filenames)) {
    stop("All BEAST2 internal filenames must be unique")
  }
}
