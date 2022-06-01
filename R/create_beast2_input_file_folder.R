#' Create the folder where the BEAST2 input file will be created
#' @inheritParams default_params_doc
#' @return nothing
#' @examples
#' check_empty_beaustier_folders()
#'
#' beast2_options <- create_beast2_options()
#' create_beast2_input_file_folder(beast2_options)
#'
#' remove_beaustier_folders()
#' check_empty_beaustier_folders()
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
