#' Internal function
#'
#' Check if the folder for the state output file
#' can be created. Will \link{stop} otherwise
#' @inheritParams default_params_doc
#' @return Nothing.
#' Will \link{stop} if the folder for the state output file
#' cannot be created
#' @examples
#' check_can_create_dir_for_state_output_file(
#'   beast2_options = create_beast2_options()
#' )
#' @author Richèl J.C. Bilderbeek
#' @export
check_can_create_dir_for_state_output_file <- function( # nolint indeed a long function name
  beast2_options
) {
  beastier::check_beast2_options(beast2_options)
  folder <- dirname(beast2_options$output_state_filename)

  # If it exists, that folder can be created
  if (dir.exists(folder)) {
    return(invisible(beast2_options))
  }

  # Create and delete the folder
  dir.create(
    path = folder,
    recursive = TRUE,
    showWarnings = FALSE
  )
  if (!dir.exists(folder)) {
    stop(
      "Cannot create folder '", folder,
      "' for BEAST2 .state.xml output file '",
      beast2_options$output_state_filename, "'"
    )
  }
  unlink(folder, recursive = TRUE)
  invisible(beast2_options)
}
