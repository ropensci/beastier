#' Extract the filenames from a `beast2_options`
#' @inheritParams default_params_doc
#' @return the filenames from a `beast2_options`
#' @author Richèl J.C. Bilderbeek
#' @examples
#' beast2_options <- create_beast2_options()
#' get_beast2_options_filenames(beast2_options)
#' @export
get_beast2_options_filenames <- function(beast2_options) {
  beastier::check_beast2_options(beast2_options)
  c(
    beast2_options$input_filename,
    beast2_options$output_state_filename
  )
}
