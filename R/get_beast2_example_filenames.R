#' Get a list with the full paths of all
#' BEAST2 example filenames
#' @inheritParams default_params_doc
#' @return a list with the full paths of all
#'   BEAST2 example filenames
#' @examples
#' if (is_beast2_installed()) {
#'   get_beast2_example_filenames()
#' }
#' @author Richèl J.C. Bilderbeek
#' @export
get_beast2_example_filenames <- function(
  beast2_folder = beastier::get_default_beast2_folder()
) {
  if (!dir.exists(beast2_folder)) {
    stop(
      "Cannot find BEAST2 example filenames in BEAST folder '",
      beast2_folder, "'. Maybe BEAST2 is not installed?"
    )
  }
  beast2_subfolder <- file.path(beast2_folder, "beast")
  beautier::check_true(dir.exists(beast2_subfolder))
  examples_folder <- file.path(beast2_subfolder, "examples")
  beautier::check_true(dir.exists(examples_folder))
  list.files(
    path = examples_folder,
    full.names = TRUE,
    recursive = TRUE
  )
}
