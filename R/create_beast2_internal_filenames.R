#' Create a list with the internally used BEAST2 filenames
#' @inheritParams default_params_doc
#' @return a list with the internally used BEAST2 filenames
#' @examples
#' beast2_options <- create_beast2_options(
#'   input_filename = get_beastier_path("2_4.xml")
#' )
#' if (is_beast2_installed()) {
#'   create_beast2_internal_filenames(beast2_options)
#' }
#' @export
create_beast2_internal_filenames <- function(beast2_options) { # nolint indeed a long function name, which is fine for internal function

  # BEAST2 Internally-used FilenameS
  bifs <- list()

  # input_filename_full
  bifs$input_filename_full <- beast2_options$input_filename
  if (basename(beast2_options$input_filename) ==
    beast2_options$input_filename
  ) {
    bifs$input_filename_full <- file.path(
      getwd(), beast2_options$input_filename
    )
  }

  # output_state_filename_full
  bifs$output_state_filename_full <- beast2_options$output_state_filename
  if (basename(beast2_options$output_state_filename) ==
      beast2_options$output_state_filename
  ) {
    bifs$output_state_filename_full <- file.path(
      getwd(), beast2_options$output_state_filename
    )
  }
  # Do not warning if the folder already exists, unless when being verbose
  dir.create(
    dirname(bifs$output_state_filename_full),
    showWarnings = FALSE, recursive = TRUE
  )

  bifs
}
