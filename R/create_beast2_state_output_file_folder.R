#' Create the folder where the BEAST2 state output file will be created
#' @inheritParams default_params_doc
#' @return nothing
#' @examples
#' beast2_options <- create_beast2_options()
#' create_beast2_state_output_file_folder(beast2_options)
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_state_output_file_folder <- function(
  beast2_options
) {
  beastier::check_beast2_options(beast2_options)
  dir.create(
    dirname(beast2_options$output_state_filename),
    showWarnings = FALSE,
    recursive = TRUE
  )
}
