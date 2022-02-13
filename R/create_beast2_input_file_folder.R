#' Create the folder where the BEAST2 input file will be created
#' @inheritParams default_params_doc
#' @return nothing
#' @examples
#' beast2_options <- create_beast2_options()
#' create_beast2_input_file_folder(beast2_options)
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_input_file_folder <- function( # nolint indeed a long function name
  beast2_options
) {
  beastier::check_beast2_options(beast2_options)
  dir.create(
    dirname(beast2_options$input_filename),
    showWarnings = FALSE,
    recursive = TRUE
  )
}
