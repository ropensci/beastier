#' Internal function
#'
#' Check if the \code{beast2_options} will not overwrite
#' existing files, when the 'overwrite' options is set to \code{FALSE}.
#'
#' Will \link{stop} if a file is threatened to be overwritten
#' @inheritParams default_params_doc
#' @return Nothing. Will \link{stop} if a file is threatened to be overwritten
#' @examples
#' check_empty_beaustier_folders()
#'
#' check_beast2_options_do_not_overwrite_existing_files(
#'   beast2_options = create_beast2_options()
#' )
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
check_beast2_options_do_not_overwrite_existing_files <- function( # nolint indeed a long function name, which is fine for internal functions
  beast2_options
) {
  check_beast2_options(beast2_options)
  if (beast2_options$overwrite) {
    return(invisible(beast2_options))
  }

  if (file.exists(beast2_options$output_state_filename)) {
    stop("Will not overwrite 'output_state_filename' ('",
      beast2_options$output_state_filename, "') with 'overwrite' is FALSE"
    )
  }
  invisible(beast2_options)
}
