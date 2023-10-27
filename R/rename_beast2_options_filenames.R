#' Rename the filenames in the BEAST2 options
#' @inheritParams default_params_doc
#' @return a `beast2_options` with the filenames it contains renamed
#' @examples
#' check_empty_beaustier_folders()
#'
#' # beast2_options with local filenames
#' beast2_options <- create_beast2_options(
#'   input_filename = "my.fas",
#'   output_state_filename = "my_state.xml.state"
#' )
#' # Rename filenames to be in /my/new/folder
#' rename_beast2_options_filenames(
#'   beast2_options = beast2_options,
#'   rename_fun = beautier::get_replace_dir_fun("/my/new/folder")
#' )
#'
#' check_empty_beaustier_folders()
#' @author Richèl J.C. Bilderbeek
#' @export
rename_beast2_options_filenames <- function( # nolint sure, this is a long function name
  beast2_options,
  rename_fun
) {
  check_beast2_options(beast2_options)
  beautier::check_rename_fun(rename_fun)
  beast2_options$input_filename <- rename_fun(beast2_options$input_filename)
  beast2_options$output_state_filename <- rename_fun(
    beast2_options$output_state_filename
  )
  beast2_options
}
