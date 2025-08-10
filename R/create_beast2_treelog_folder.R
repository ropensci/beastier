#' Internal function
#'
#' Create the folder for the BEAST2 treelog file
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
create_beast2_treelog_folder <- function(beast2_options) {
  # Extract the treelog file
  beautier::check_true(file.exists(beast2_options$input_filename))
  treelog_filename <- beastier::extract_treelog_filename_from_beast2_input_file(
    input_filename = beast2_options$input_filename
  )
  dir.create(
    dirname(treelog_filename),
    showWarnings = FALSE,
    recursive = TRUE
  )
  beautier::check_true(
    dir.exists(dirname(treelog_filename))
  )
  invisible(beast2_options)
}
