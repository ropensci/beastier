#' Rename the filenames in the BEAST2 options
#' @inheritParams default_params_doc
#' @export
rename_beast2_options_filenames <- function(
  beast2_options,
  rename_fun
) {
  beastier::check_beast2_options(beast2_options)
  beautier::check_rename_fun(rename_fun)
  beast2_options$input_filename <- rename_fun(beast2_options$input_filename)
  beast2_options$output_state_filename <- rename_fun(
    beast2_options$output_state_filename
  )
  beast2_options
}
