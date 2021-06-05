#' Check if the state output file
#' can be created. Will \link{stop} otherwise
#' @inheritParams default_params_doc
#' @export
check_can_create_state_output_file <- function( # nolint indeed a long function name
  beast2_options
) {
  beastier::check_beast2_options(beast2_options)
  beastier::check_can_create_dir_for_state_output_file(beast2_options)
  if (file.exists(beast2_options$output_state_filename)) return()

  dir.create(
    path = dirname(beast2_options$output_state_filename),
    showWarnings = FALSE,
    recursive = TRUE
  )

  # Use a more precise error message
  tryCatch(
    beastier::check_can_create_file(
      filename = beast2_options$output_state_filename,
      overwrite = FALSE
    ),
    error = function(e) {
      stop(
        "Cannot create BEAST2 .xml.state output file at path '",
        beast2_options$output_state_filename, "'"
      )
    }
  )
}
